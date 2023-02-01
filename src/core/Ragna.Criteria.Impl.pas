unit Ragna.Criteria.Impl;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses {$IFDEF UNIDAC}Uni{$ELSE}FireDAC.Comp.Client, FireDAC.Stan.Param{$ENDIF},
  StrUtils, Data.DB, System.Hash, Ragna.Criteria.Intf, Ragna.Types;

type
  TDefaultCriteria = class(TInterfacedObject, ICriteria)
  private
    FQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF};
    procedure Where(const AField: string);
    procedure &Or(const AField: string);
    procedure &And(const AField: string);
    procedure Like(const AValue: string);
    procedure &Equals(const AValue: Int64); reintroduce; overload;
    procedure &Equals(const AValue: Boolean); reintroduce; overload;
    procedure &Equals(const AValue: string); reintroduce; overload;
    procedure Order(const AField: string);
  public
    constructor Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
  end;

  TManagerCriteria = class
  private
    FCriteria: ICriteria;
    function GetDrive(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}): string;
    function GetInstanceCriteria(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}): ICriteria;
  public
    constructor Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

uses FireDAC.Stan.Intf, SysUtils;

procedure TDefaultCriteria.&And(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.AND.ToString, AField]));
end;

procedure TDefaultCriteria.&Or(const AField: string);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.OR.ToString, AField]));
end;

constructor TDefaultCriteria.Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
begin
  FQuery := AQuery;
end;

procedure TDefaultCriteria.Equals(const AValue: Boolean);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.EQUALS.ToString, BoolToStr(AValue, True)]));
end;

procedure TDefaultCriteria.Equals(const AValue: Int64);
const
  PHRASE = '%s %d';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.EQUALS.ToString, AValue]));
end;

procedure TDefaultCriteria.Equals(const AValue: string);
const
  PHRASE = '%s ''%s''';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.EQUALS.ToString, AValue]));
end;

procedure TDefaultCriteria.Like(const AValue: string);
const
  PHRASE = ' %s %s';
var
  LKeyParam: string;
  LParam: {$IFDEF UNIDAC}TUniParam{$ELSE}TFDParam{$ENDIF};
begin
  LKeyParam := THashMD5.Create.HashAsString;
  FQuery.SQL.Text := FQuery.SQL.Text + Format(PHRASE, [TOperatorType.LIKE.ToString, ':' + LKeyParam]);
  LParam := FQuery.ParamByName(LKeyParam);
  LParam.DataType := ftString;
  if Pos('%', AValue) <= 0 then
    LParam.Value := AValue + '%'
  else
    LParam.Value := AValue;
end;

procedure TDefaultCriteria.Where(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.WHERE.ToString, AField]));
end;

procedure TDefaultCriteria.Order(const AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(Format(PHRASE, [TOperatorType.ORDER.ToString, AField]));
end;

constructor TManagerCriteria.Create(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF});
begin
  FCriteria := GetInstanceCriteria(AQuery);
end;

function TManagerCriteria.GetDrive(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}): string;
{$IFDEF UNIDAC}
begin
  Result := AQuery.Connection.ProviderName;
end;
{$ELSE}
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
{$ENDIF}

function TManagerCriteria.GetInstanceCriteria(const AQuery: {$IFDEF UNIDAC}TUniQuery{$ELSE}TFDQuery{$ENDIF}): ICriteria;
begin
  case AnsiIndexStr(GetDrive(AQuery), ['PG']) of
    0:
      Result := TDefaultCriteria.Create(AQuery);
    else
      Result := TDefaultCriteria.Create(AQuery);
  end;
end;

end.

