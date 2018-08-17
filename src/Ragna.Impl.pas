unit Ragna.Impl;

interface

uses Ragna.Intf, FireDAC.Comp.Client, System.JSON, Data.DB, Ragna.Criteria,
  DataSetConverter4D.Helper;

type

  TRagna = class(TInterfacedObject, IRagna)
  private
    FQuery: TFDQuery;
    FManagerCriteria: TManagerCriteria;
    FCriteria: ICriteria;
  private
    function GetTableName: string;
    function HasField(AFields: array of TField): Boolean;
    procedure OpenEmpty;
    procedure RaiseNotFound;
  public
    procedure Paginate(AOffSet, ALimit: integer);
    procedure RadicalResearch(AValue: string; AFields: array of TField);
    procedure Delete(AField: TField; AValue: Int64);
    procedure FindById(AField: TField; AValue: Int64);
    procedure UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject);
    procedure New(ABody: TJSONObject);
    procedure OpenUp;
    procedure StartCriteria;
    procedure EndCriteria;
    procedure ToJson(out AJSON: TJSONArray); overload;
    procedure ToJson(out AJSON: TJSONObject); overload;
    procedure FromJson(const AJSON: TJSONObject);
    constructor Create(AQuery: TFDQuery);
    destructor Destroy;
    property Query: TFDQuery read FQuery write FQuery;
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

{ TRagna }

uses Ragna.State, System.SysUtils, Ragna;

constructor TRagna.Create(AQuery: TFDQuery);
begin
  FQuery := AQuery;
  FManagerCriteria := TManagerCriteria.Create(FQuery);
  FCriteria := FManagerCriteria.Criteria;
end;

procedure TRagna.Delete(AField: TField; AValue: Int64);
const
  DELETE_SQL = 'DELETE FROM %s WHERE %s = :ID';
  DELETED: array [0 .. 1] of Boolean = (False, True);
var
  LDeleted: integer;
  LSql: string;
begin
  OpenEmpty;
  LSql := Format(DELETE_SQL, [GetTableName, AField.FieldName]);
  LDeleted := FQuery.Connection.ExecSQL(LSql, [AValue]);
  if not DELETED[LDeleted] then
    RaiseNotFound;
end;

destructor TRagna.Destroy;
begin
  FManagerCriteria.Free;
end;

procedure TRagna.EndCriteria;
var
  LKey: Pointer;
  LRagnaState: TRagnaState;
begin
  LKey := @FQuery;
  LRagnaState := TRagnaState.GetInstance;
  FQuery.SQL.Text := LRagnaState.RemoveState(LKey);
end;

procedure TRagna.FindById(AField: TField; AValue: Int64);
var
  LField: string;
begin
  FQuery.StartCriteria;
  try
    OpenEmpty;
    LField := GetTableName + '.' + AField.Origin;
  finally
    FQuery.EndCriteria;
  end;

  FQuery
    .Where(LField)
    .Equals(AValue);
end;

procedure TRagna.FromJson(const AJSON: TJSONObject);
begin
  FQuery.RecordFromJSONObject(AJSON);
end;

function TRagna.GetTableName: string;
begin
  Result := FQuery.Table.Table.SourceName;
end;

function TRagna.HasField(AFields: array of TField): Boolean;
begin
  Result := Length(AFields) > 0;
end;

procedure TRagna.OpenUp;
begin
  FQuery.Open;
end;

procedure TRagna.OpenEmpty;
begin
  FQuery.Where(True).Equals(False).OpenUp;
end;

procedure TRagna.Paginate(AOffSet, ALimit: integer);
begin
  if AOffSet > 0 then
    FQuery.FetchOptions.RecsSkip := AOffSet;

  if ALimit > 0 then
    FQuery.FetchOptions.RecsMax := ALimit;
end;

procedure TRagna.New(ABody: TJSONObject);
begin
  OpenEmpty;
  FQuery.FromJson(ABody);
end;

procedure TRagna.RadicalResearch(AValue: string; AFields: array of TField);
var
  LSearch: string;
  LCount: integer;
begin
  if HasField(AFields) and not AValue.IsEmpty then
  begin
    LSearch := '%' + AValue + '%';
    
    FQuery
      .Where(AFields[0])
      .Like(LSearch);

    if ((Length(AFields) - 1) >= 2) then
    begin
      for LCount := 1 to Length(AFields) - 1 do
      begin
        FQuery
          .&Or(AFields[LCount])
          .Like(LSearch);
      end;
    end;
  end;
end;

procedure TRagna.RaiseNotFound;
begin
  raise Exception.Create('Resource not found!');
end;

procedure TRagna.StartCriteria;
var
  LKey: Pointer;
  LRagnaState: TRagnaState;
begin
  LKey := @FQuery;
  LRagnaState := TRagnaState.GetInstance;

  if LRagnaState.GetState(LKey).IsEmpty then
    LRagnaState.SetState(LKey, FQuery.SQL.Text)
end;

procedure TRagna.ToJson(out AJSON: TJSONObject);
begin
  if FQuery.IsEmpty then
    RaiseNotFound;

  AJSON := FQuery.AsJSONObject;
end;

procedure TRagna.ToJson(out AJSON: TJSONArray);
begin
  if FQuery.IsEmpty then
    AJSON := TJSONArray.Create
  else
    AJSON := FQuery.AsJSONArray;
end;

procedure TRagna.UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject);
begin
  FQuery
    .FindById(AField, AValue)
    .OpenUp
    .FromJson(ABody);
end;

end.