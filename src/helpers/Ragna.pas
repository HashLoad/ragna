unit Ragna;

interface

uses FireDAC.Comp.Client, System.JSON, Data.DB, Ragna.Impl, Ragna.Criteria.Impl;

type
  TRagnaHelper = class helper for TFDQuery
  public
    function Paginate(const AOffSet, ALimit: Integer): TFDQuery;
    function RadicalResearch(const AValue: string; const AFields: array of TField): TFDQuery;
    function Remove(const AField: TField; const AValue: Int64): TFDQuery;
    function FindById(const AField: TField; const AValue: Int64): TFDQuery;
    function UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject): TFDQuery;
    function New(const ABody: TJSONObject): TFDQuery; overload;
    function New(const ABody: TJSONArray): TFDQuery; overload;
    function OpenUp: TFDQuery;
    function OpenEmpty: TFDQuery;
    function Reset: TFDQuery;
    function ToJson(out AJSON: TJSONArray): TFDQuery; overload; deprecated;
    function ToJson(out AJSON: TJSONObject): TFDQuery; overload; deprecated;
    function ToJSONObject: TJSONObject;
    function ToJSONArray: TJSONArray;
    function EditFromJson(const AJSON: TJSONObject): TFDQuery; overload;
    function EditFromJson(const AJSON: TJSONArray): TFDQuery; overload;
    function Where(const AField: string): TFDQuery; overload;
    function Where(const AField: TField): TFDQuery; overload;
    function Where(const AValue: Boolean): TFDQuery; overload;
    function &Or(const AField: TField): TFDQuery; overload;
    function &Or(const AField: string): TFDQuery; overload;
    function &And(const AField: TField): TFDQuery; overload;
    function &And(const AField: string): TFDQuery; overload;
    function Like(const AValue: string): TFDQuery;
    function &Equals(const AValue: Int64): TFDQuery; overload;
    function &Equals(const AValue: Boolean): TFDQuery; overload;
    function &Equals(const AValue: string): TFDQuery; overload;
    function Order(const AField: TField): TFDQuery;
  end;

implementation

uses System.SysUtils, Ragna.Intf;

function TRagnaHelper.&Or(const AField: TField): TFDQuery;
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

function TRagnaHelper.&And(const AField: TField): TFDQuery;
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

function TRagnaHelper.&And(const AField: string): TFDQuery;
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

function TRagnaHelper.&Or(const AField: string): TFDQuery;
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

function TRagnaHelper.Remove(const AField: TField; const AValue: Int64): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Remove(AField, AValue);
  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONArray): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.EditFromJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.Equals(const AValue: string): TFDQuery;
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Criteria.Equals(AValue);
  Result := Self;
end;

function TRagnaHelper.Equals(const AValue: Boolean): TFDQuery;
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

function TRagnaHelper.Equals(const AValue: Int64): TFDQuery;
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

function TRagnaHelper.FindById(const AField: TField; const AValue: Int64): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.FindById(AField, AValue);
  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONObject): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.EditFromJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.Like(const AValue: string): TFDQuery;
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

function TRagnaHelper.New(const ABody: TJSONArray): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.New(ABody);
  Result := Self;
end;

function TRagnaHelper.OpenEmpty: TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.OpenEmpty;
  Result := Self;
end;

function TRagnaHelper.OpenUp: TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.OpenUp;
  Result := Self;
end;

function TRagnaHelper.Order(const AField: TField): TFDQuery;
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

function TRagnaHelper.Paginate(const AOffSet, ALimit: Integer): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Paginate(AOffSet, ALimit);
  Result := Self;
end;

function TRagnaHelper.New(const ABody: TJSONObject): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.New(ABody);
  Result := Self;
end;

function TRagnaHelper.RadicalResearch(const AValue: string; const AFields: array of TField): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.RadicalResearch(AValue, AFields);
  Result := Self;
end;

function TRagnaHelper.Reset: TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Reset;
  Result := Self;
end;

function TRagnaHelper.ToJson(out AJSON: TJSONObject): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.ToJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.ToJSONArray: TJSONArray;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  Result := LRagna.ToJSONArray;
end;

function TRagnaHelper.ToJSONObject: TJSONObject;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  Result := LRagna.ToJSONObject;
end;

function TRagnaHelper.ToJson(out AJSON: TJSONArray): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.ToJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.UpdateById(AField, AValue, ABody);
  Result := Self;
end;

function TRagnaHelper.Where(const AField: string): TFDQuery;
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

function TRagnaHelper.Where(const AValue: Boolean): TFDQuery;
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

function TRagnaHelper.Where(const AField: TField): TFDQuery;
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
