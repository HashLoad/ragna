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
    procedure OpenEmpty;
  public
    procedure Paginate(AOffSet, ALimit: integer);
    procedure RadicalResearch(AValue: string; AFields: array of TFields);
    procedure Delete(AField: TField; AValue: Int64);
    procedure FindById(AField: TField; AValue: Int64);
    procedure UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject);
    procedure New(ABody: TJSONObject);
    procedure Open;
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
  LSql := Format(DELETE_SQL, [GetTableName, AField.Origin]);
  LDeleted := FQuery.Connection.ExecSQL(LSql, [AValue]);
  if not DELETED[LDeleted] then
    raise Exception.Create('resource not found');
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
begin
  FQuery
    .Where(AField)
    .Equals(AValue);
end;

procedure TRagna.FromJson(const AJSON: TJSONObject);
begin
  FQuery.RecordFromJSONObject(AJSON);
end;

function TRagna.GetTableName: string;
const
  NOT_FOUND_ID = -1;
  NOT_EQUALS_VALUE_ID = '0';
begin
  FindById(NOT_FOUND_ID, NOT_EQUALS_VALUE_ID);
  Result := FQuery.Table.Table.SourceName;
end;

procedure TRagna.Open;
begin
  FQuery.Open;
end;

procedure TRagna.OpenEmpty;
begin
  FQuery
    .Where(True)
    .Equals(False)
    .Open;
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
  FQuery
    .FromJson(ABody);
end;

procedure TRagna.RadicalResearch(AValue: string; AFields: array of TFields);
begin

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
    AJSON := TJSONObject.Create
  else
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
    .Open
    .FromJson(ABody);
end;

end.
