unit Ragna;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses {$IFDEF UNIDAC}Uni{$ELSE}FireDAC.Comp.Client{$ENDIF}, System.JSON, Data.DB, Ragna.Impl, Ragna.Criteria.Impl;

type
  TRagnaHelper = class helper for {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}
  public
    function Paginate(const AOffSet, ALimit: Integer): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function RadicalResearch(const AValue: string; const AFields: array of TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function Remove(const AField: TField; const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function FindById(const AField: TField; const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function Reset: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function OpenUp: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function OpenEmpty: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    function ToJSONObject: TJSONObject;
    function ToJSONArray: TJSONArray;
    function New(const ABody: TJSONObject): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function New(const ABody: TJSONArray): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function New(const ABody: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function EditFromJson(const AJSON: TJSONObject): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function EditFromJson(const AJSON: TJSONArray): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function EditFromJson(const AJSON: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Where(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Where(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Where(const AValue: Boolean): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &Or(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &Or(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &And(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &And(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Like(const AValue: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Like(const AValue: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &Equals(const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &Equals(const AValue: Boolean): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function &Equals(const AValue: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Order(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
    function Order(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}; overload;
  end;

implementation

uses System.SysUtils, Ragna.Intf;

function TRagnaHelper.&Or(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := &Or(AField.Origin);
end;

function TRagnaHelper.&And(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := &And(AField.Origin);
end;

function TRagnaHelper.&And(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.&Or(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.Order(const AField: string): TFDQuery;
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

function TRagnaHelper.Remove(const AField: TField; const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Remove(AField, AValue);
  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONArray): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.EditFromJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.EditFromJson(const AJSON: string): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.EditFromJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.Equals(const AValue: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: TRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Criteria.Equals(AValue);
  Result := Self;
end;

function TRagnaHelper.Equals(const AValue: Boolean): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.Equals(const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.FindById(const AField: TField; const AValue: Int64): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.FindById(AField, AValue);
  Result := Self;
end;

function TRagnaHelper.Like(const AValue: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := Like(AValue.AsString);
end;

function TRagnaHelper.EditFromJson(const AJSON: TJSONObject): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.EditFromJson(AJSON);
  Result := Self;
end;

function TRagnaHelper.Like(const AValue: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.New(const ABody: TJSONArray): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.New(ABody);
  Result := Self;
end;

function TRagnaHelper.OpenEmpty: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.OpenEmpty;
  Result := Self;
end;

function TRagnaHelper.OpenUp: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.OpenUp;
  Result := Self;
end;

function TRagnaHelper.Order(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := Order(AField.Origin);
end;

function TRagnaHelper.Paginate(const AOffSet, ALimit: Integer): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Paginate(AOffSet, ALimit);
  Result := Self;
end;

function TRagnaHelper.New(const ABody: TJSONObject): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.New(ABody);
  Result := Self;
end;

function TRagnaHelper.RadicalResearch(const AValue: string; const AFields: array of TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.RadicalResearch(AValue, AFields);
  Result := Self;
end;

function TRagnaHelper.Reset: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.Reset;
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

function TRagnaHelper.UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.UpdateById(AField, AValue, ABody);
  Result := Self;
end;

function TRagnaHelper.Where(const AField: string): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
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

function TRagnaHelper.Where(const AValue: Boolean): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := Where(BoolToStr(AValue, True));
end;

function TRagnaHelper.Where(const AField: TField): {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
begin
  Result := Where(AField.Origin);
end;

function TRagnaHelper.New(const ABody: string): TFDQuery;
var
  LRagna: IRagna;
begin
  LRagna := TRagna.Create(Self);
  LRagna.New(ABody);
  Result := Self;
end;

end.
