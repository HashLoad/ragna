unit Ragna.Criteria.Impl;

interface

uses FireDAC.Comp.Client, StrUtils, Data.DB, FireDAC.Stan.Param, System.Hash, Ragna.Criteria.Intf, Ragna.Types;

type
  TDefaultCriteria = class(TInterfacedObject, ICriteria)
  private
    FQuery: TFDQuery;
    procedure Where(const AField: string); overload;
    procedure Where(const AField: TField); overload;
    procedure Where(const AValue: Boolean); overload;
    procedure &Or(const AField: string); overload;
    procedure &Or(const AField: TField); overload;
    procedure &And(const AField: string); overload;
    procedure &And(const AField: TField); overload;
    procedure Like(const AValue: string);
    procedure &Equals(const AValue: Int64); overload;
    procedure &Equals(const AValue: Boolean); overload;
    procedure &Equals(const AValue: string); overload;
    procedure Order(const AField: string); overload;
    procedure Order(const AField: TField); overload;
  public
    constructor Create(const AQuery: TFDQuery);
  end;

  TManagerCriteria = class
  private
    FCriteria: ICriteria;
    function GetDrive(const AQuery: TFDQuery): string;
    function GetInstanceCriteria(const AQuery: TFDQuery): ICriteria;
  public
    constructor Create(const AQuery: TFDQuery);
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

uses FireDAC.Stan.Intf, SysUtils;

procedure TDefaultCriteria.&And(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [otAnd.ToString, AField]));
end;

procedure TDefaultCriteria.&And(const AField: TField);
begin
  Self.&And(AField.Origin);
end;

procedure TDefaultCriteria.&Or(const AField: string);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [otOr.ToString, AField]));
end;

constructor TDefaultCriteria.Create(const AQuery: TFDQuery);
begin
  FQuery := AQuery;
end;

procedure TDefaultCriteria.Equals(const AValue: string);
const
  PHRASE = '%s ''%s''';
begin
  FQuery.SQL.Add(Format(PHRASE, [otEquals.ToString, AValue]));
end;

procedure TDefaultCriteria.Equals(const AValue: Int64);
const
  PHRASE = '%s %d';
begin
  FQuery.SQL.Add(Format(PHRASE, [otEquals.ToString, AValue]));
end;

procedure TDefaultCriteria.Where(const AField: TField);
begin
  Self.Where(AField.Origin);
end;

procedure TDefaultCriteria.Equals(const AValue: Boolean);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [otEquals.ToString, BoolToStr(AValue, True)]));
end;

procedure TDefaultCriteria.Like(const AValue: string);
const
  PHRASE = '::text %s %s';
var
  LKeyParam: string;
  LParam: TFDParam;
begin
  LKeyParam := THashMD5.Create.HashAsString;
  FQuery.SQL.Text := FQuery.SQL.Text + Format(PHRASE, [otLike.ToString, ':' + LKeyParam]);
  LParam := FQuery.ParamByName(LKeyParam);
  LParam.DataType := ftString;
  LParam.Value := AValue;
end;

procedure TDefaultCriteria.Order(const AField: TField);
begin
  Self.Order(AField.Origin);
end;

procedure TDefaultCriteria.Where(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [otWhere.ToString, AField]));
end;

procedure TDefaultCriteria.Where(const AValue: Boolean);
begin
  Self.Where(BoolToStr(AValue, True));
end;

procedure TDefaultCriteria.&Or(const AField: TField);
begin
  Self.&Or(AField.Origin);
end;

procedure TDefaultCriteria.Order(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [otOrder.ToString, AField]));
end;

constructor TManagerCriteria.Create(const AQuery: TFDQuery);
begin
  FCriteria := GetInstanceCriteria(AQuery);
end;

function TManagerCriteria.GetDrive(const AQuery: TFDQuery): string;
var
  LDef: IFDStanConnectionDef;
begin
  Result := AQuery.Connection.DriverName;
  if Result.IsEmpty and not AQuery.Connection.ConnectionDefName.IsEmpty then
  begin
    LDef := FDManager.ConnectionDefs.FindConnectionDef(AQuery.Connection.ConnectionDefName);
    if LDef = nil then
      raise Exception.Create('ConnectionDefs "' + AQuery.Connection.ConnectionDefName + '" not found');
    Result := LDef.Params.DriverID;
  end;
end;

function TManagerCriteria.GetInstanceCriteria(const AQuery: TFDQuery): ICriteria;
begin
  case AnsiIndexStr(GetDrive(AQuery), ['PG']) of
    0:
      Result := TDefaultCriteria.Create(AQuery);
    else
      Result := TDefaultCriteria.Create(AQuery);
  end;
end;

end.
