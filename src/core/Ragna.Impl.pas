unit Ragna.Impl;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses {$IFDEF UNIDAC}Uni, SqlClassesUni{$ELSE}FireDAC.Comp.Client{$ENDIF}, Ragna.Intf, Ragna.Criteria.Intf, System.JSON, Data.DB, Ragna.Criteria.Impl;

type
  TRagna = class(TInterfacedObject, IRagna)
  private
    FQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    FManagerCriteria: TManagerCriteria;
    FCriteria: ICriteria;
    procedure SaveState;
  private
    {$IFDEF UNIDAC}
    function GetTableName(AField: TField): string;
    {$ELSE}
    function GetTableName: string;
    {$ENDIF}
    function HasField(const AFields: array of TField): Boolean;
    function ToJSONObject: TJSONObject;
    function ToJSONArray: TJSONArray;
    procedure RaiseNotFound;
    procedure Paginate(const AOffSet, ALimit: Integer); {$IFDEF UNIDAC} deprecated 'Not implemented for UniDAC';{$ENDIF}
    procedure RadicalResearch(const AValue: string; const AFields: array of TField);
    procedure Remove(const AField: TField; const AValue: Int64);
    procedure FindById(const AField: TField; const AValue: Int64);
    procedure UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject);
    procedure OpenUp;
    procedure OpenEmpty;
    procedure Reset;
    procedure EditFromJson(const AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONArray); overload;
    procedure EditFromJson(const AJSON: string); overload;
    procedure New(const ABody: TJSONObject); overload;
    procedure New(const ABody: TJSONArray); overload;
    procedure New(const ABody: string); overload;
  public
    constructor Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
    property Query: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF} read FQuery write FQuery;
    property Criteria: ICriteria read FCriteria write FCriteria;
    destructor Destroy; override;
  end;

implementation

uses Ragna.State, System.SysUtils, Ragna, DataSet.Serialize;

constructor TRagna.Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
begin
  FQuery := AQuery;
  SaveState;
  FManagerCriteria := TManagerCriteria.Create(FQuery);
  FCriteria := FManagerCriteria.Criteria;
end;

procedure TRagna.Remove(const AField: TField; const AValue: Int64);
const
  DELETE_SQL = 'DELETE FROM %s WHERE %s = :ID';
  DELETED: array [0 .. 1] of Boolean = (False, True);
var
  LDeleted: Integer;
  LSql: string;
begin
  OpenEmpty;
  LSql := Format(DELETE_SQL, [{$IFDEF UNIDAC}GetTableName(AField){$ELSE}GetTableName{$ENDIF}, AField.FieldName]);
  LDeleted := FQuery.Connection.ExecSQL(LSql, [AValue]);
  if not DELETED[LDeleted] then
    RaiseNotFound;
end;

destructor TRagna.Destroy;
begin
  FManagerCriteria.Free;
end;

procedure TRagna.EditFromJson(const AJSON: string);
begin
  FQuery.MergeFromJSONObject(AJSON);
end;

procedure TRagna.SaveState;
var
  LSql: string;
begin
  if not TRagnaState.GetInstance.GetState(FQuery, LSql) then
    TRagnaState.GetInstance.SetState(FQuery, FQuery.SQL.Text);
end;

procedure TRagna.EditFromJson(const AJSON: TJSONArray);
begin
  FQuery.LoadFromJSON(AJSON, False);
end;

procedure TRagna.FindById(const AField: TField; const AValue: Int64);
var
  LField: string;
begin
  OpenEmpty;
  LField := {$IFDEF UNIDAC}GetTableName(AField){$ELSE}GetTableName{$ENDIF} + '.' + AField.Origin;
  FQuery.Reset.Where(LField).Equals(AValue);
end;

procedure TRagna.EditFromJson(const AJSON: TJSONObject);
begin
  FQuery.MergeFromJSONObject(AJSON, False);
end;

{$IFDEF UNIDAC}
function TRagna.GetTableName(AField: TField): string;
var
  LFieldDesc: TSqlFieldDesc;
begin
  LFieldDesc := TSqlFieldDesc(FQuery.GetFieldDesc(AField));
  Result := LFieldDesc.BaseTableName;
end;
{$ELSE}
function TRagna.GetTableName: string;
begin
  Result := FQuery.Table.Table.SourceName;
end;
{$ENDIF}

function TRagna.HasField(const AFields: array of TField): Boolean;
begin
  Result := Length(AFields) > 0;
end;

procedure TRagna.New(const ABody: string);
begin
  OpenEmpty;
  FQuery.LoadFromJSON(ABody);
end;

procedure TRagna.New(const ABody: TJSONArray);
begin
  OpenEmpty;
  FQuery.LoadFromJSON(ABody);
end;

procedure TRagna.OpenUp;
begin
  FQuery.Open;
end;

procedure TRagna.OpenEmpty;
begin
  FQuery.Where('1').Equals('2').OpenUp;
end;

procedure TRagna.Paginate(const AOffSet, ALimit: Integer);
begin
  {$IFDEF UNIDAC}
  raise Exception.Create('Not implemented for UniDAC');
  {$ELSE}
  if AOffSet > 0 then
    FQuery.FetchOptions.RecsSkip := AOffSet;
  if ALimit > 0 then
    FQuery.FetchOptions.RecsMax := ALimit;
  {$ENDIF}
end;

procedure TRagna.New(const ABody: TJSONObject);
begin
  OpenEmpty;
  FQuery.LoadFromJSON(ABody);
end;

procedure TRagna.RadicalResearch(const AValue: string; const AFields: array of TField);
var
  LSearch: string;
  LCount: Integer;
begin
  if HasField(AFields) and not AValue.IsEmpty then
  begin
    LSearch := '%' + AValue + '%';
    FQuery.Where(AFields[0]).Like(LSearch);
    if ((Length(AFields) - 1) >= 2) then
    begin
      for LCount := 1 to Length(AFields) - 1 do
        FQuery.&Or(AFields[LCount]).Like(LSearch);
    end;
  end;
end;

procedure TRagna.RaiseNotFound;
begin
  raise Exception.Create('Resource not found!');
end;

procedure TRagna.Reset;
var
  LSql: string;
begin
  TRagnaState.GetInstance.GetState(FQuery, LSql);
  FQuery.SQL.Text := LSql;
end;

function TRagna.ToJSONArray: TJSONArray;
begin
  Result := (FQuery as TDataSet).ToJSONArray;
end;

function TRagna.ToJSONObject: TJSONObject;
begin
  if FQuery.IsEmpty then
    RaiseNotFound;
  Result := (FQuery as TDataSet).ToJSONObject;
end;

procedure TRagna.UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject);
begin
  FQuery.FindById(AField, AValue).OpenUp.MergeFromJSONObject(ABody, False);
end;

end.
