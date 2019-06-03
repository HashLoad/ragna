unit Ragna;

interface

uses
  FireDAC.Comp.Client, System.JSON, Data.DB, Ragna.Impl;

type

  TRagnaHelper = class helper for TFDQuery
  public
    function Paginate(AOffSet, ALimit: integer): TFDQuery;
    function RadicalResearch(AValue: string; AFields: array of TField)
      : TFDQuery;
    function Delete(AField: TField; AValue: Int64): TFDQuery;
    function FindById(AField: TField; AValue: Int64): TFDQuery;
    function UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject)
      : TFDQuery;
    function New(ABody: TJSONObject): TFDQuery; overload;
    function New(ABody: TJSONArray): TFDQuery; overload;
    function OpenUp: TFDQuery;
    function StartCriteria: TFDQuery; deprecated;
    function EndCriteria: TFDQuery; deprecated;
    function Reset: TFDQuery;
    function ToJson(out AJSON: TJSONArray): TFDQuery; overload;
    function ToJson(out AJSON: TJSONObject): TFDQuery; overload;
    function EditFromJson(const AJSON: TJSONObject): TFDQuery; overload;
    function EditFromJson(const AJSON: TJSONArray): TFDQuery; overload;
    function Where(AField: string): TFDQuery; overload;
    function Where(AField: TField): TFDQuery; overload;
    function Where(AValue: Boolean): TFDQuery; overload;
    function &Or(AField: TField): TFDQuery; overload;
    function &Or(AField: string): TFDQuery; overload;
    function &And(AField: TField): TFDQuery; overload;
    function &And(AField: string): TFDQuery; overload;
    function Like(AValue: string): TFDQuery;
    function &Equals(AValue: Int64): TFDQuery; overload;
    function &Equals(AValue: Boolean): TFDQuery; overload;
    function &Equals(AValue: String): TFDQuery; overload;
    function Order(AField: TField): TFDQuery;
  end;

implementation

uses System.SysUtils;

function TRagnaHelper.&Or(AField: TField): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.&Or(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.&And(AField: TField): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.&And(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.&And(AField: string): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.&And(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.&Or(AField: string): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.&Or(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Delete(AField: TField; AValue: Int64): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Delete(AField, AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONArray): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.EditFromJson(AJSON);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.EndCriteria: TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.EndCriteria;
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Equals(AValue: String): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Equals(AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Equals(AValue: Boolean): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Equals(AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Equals(AValue: Int64): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Equals(AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.FindById(AField: TField; AValue: Int64): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.FindById(AField, AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONObject): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.EditFromJson(AJSON);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Like(AValue: string): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Like(AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.New(ABody: TJSONArray): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.New(ABody);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.OpenUp: TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.OpenUp;
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Order(AField: TField): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Order(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Paginate(AOffSet, ALimit: integer): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Paginate(AOffSet, ALimit);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.New(ABody: TJSONObject): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.New(ABody);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.RadicalResearch(AValue: string; AFields: array of TField)
  : TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.RadicalResearch(AValue, AFields);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Reset: TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Reset;
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.StartCriteria: TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.StartCriteria;
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.ToJson(out AJSON: TJSONObject): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.ToJson(AJSON);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.ToJson(out AJSON: TJSONArray): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.ToJson(AJSON);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.UpdateById(AField: TField; AValue: Int64;
  ABody: TJSONObject): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.UpdateById(AField, AValue, ABody);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Where(AField: string): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Where(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Where(AValue: Boolean): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Where(AValue);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

function TRagnaHelper.Where(AField: TField): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  try
    LRagna.Criteria.Where(AField);
  finally
    LRagna.Free;
  end;

  Result := Self;
end;

end.
