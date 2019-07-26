unit Ragna.Impl;

interface

uses Ragna.Intf, FireDAC.Comp.Client, System.JSON, Data.DB, Ragna.Criteria;

type

  TRagna = class(TInterfacedObject, IRagna)
  private
    FQuery: TFDQuery;
    FManagerCriteria: TManagerCriteria;
    FCriteria: ICriteria;
    procedure SaveState;
  private
    function GetTableName: string;
    function HasField(AFields: array of TField): Boolean;
    procedure OpenEmpty;
    procedure RaiseNotFound;
  public
    procedure Paginate(AOffSet, ALimit: integer);
    procedure RadicalResearch(AValue: string; AFields: array of TField);
    procedure Remove(AField: TField; AValue: Int64);
    procedure FindById(AField: TField; AValue: Int64);
    procedure UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject);
    procedure New(ABody: TJSONObject); overload;
    procedure New(ABody: TJSONArray); overload;
    procedure OpenUp;
    procedure StartCriteria; deprecated;
    procedure EndCriteria; deprecated;
    procedure Reset;
    procedure ToJson(out AJSON: TJSONArray); overload;
    procedure ToJson(out AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONArray); overload;
    constructor Create(AQuery: TFDQuery);
    destructor Destroy; Override;
    property Query: TFDQuery read FQuery write FQuery;
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

{ TRagna }

uses Ragna.State, System.SysUtils, Ragna, DataSetConverter4D;

constructor TRagna.Create(AQuery: TFDQuery);
begin
  FQuery := AQuery;
  SaveState;
  FManagerCriteria := TManagerCriteria.Create(FQuery);
  FCriteria := FManagerCriteria.Criteria;
end;

procedure TRagna.Remove(AField: TField; AValue: Int64);
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

procedure TRagna.SaveState;
var
  LKey: TFDQuery;
  LSQL: string;
  LRagnaState: TRagnaState;
begin
  LKey := FQuery;
  LRagnaState := TRagnaState.GetInstance;
  if not LRagnaState.GetState(LKey, LSQL) then
    LRagnaState.SetState(LKey, FQuery.SQL.Text);
end;

procedure TRagna.EditFromJson(const AJSON: TJSONArray);
begin
  FQuery.FromJSONArray(AJSON);
end;

procedure TRagna.EndCriteria;
begin
  Reset;
end;

procedure TRagna.FindById(AField: TField; AValue: Int64);
var
  LField: string;
begin
  OpenEmpty;
  LField := GetTableName + '.' + AField.Origin;

  FQuery
    .Reset
    .Where(LField)
    .Equals(AValue);
end;

procedure TRagna.EditFromJson(const AJSON: TJSONObject);
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

procedure TRagna.New(ABody: TJSONArray);
begin
  OpenEmpty;
  FQuery.EditFromJson(ABody);
end;

procedure TRagna.OpenUp;
begin
  FQuery.Open;
end;

procedure TRagna.OpenEmpty;
begin
  FQuery
    .Where('1')
    .Equals('2')
    .OpenUp;
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
  FQuery.EditFromJson(ABody);
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

procedure TRagna.Reset;
var
  LKey: TFDQuery;
  LSQL: string;
  LRagnaState: TRagnaState;
begin
  LKey := FQuery;
  LRagnaState := TRagnaState.GetInstance;
  LRagnaState.GetState(LKey, LSQL);
  FQuery.SQL.Text := LSQL;
end;

procedure TRagna.StartCriteria;
begin
//  SaveState;
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
    .EditFromJson(ABody);
end;

end.
