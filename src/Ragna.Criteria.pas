unit Ragna.Criteria;

interface

uses
  FireDAC.Comp.Client, StrUtils, Ragna.Intf, Data.DB, FireDAC.Stan.Param,
  System.Hash;

type

  TOperatorType = (otWhere, otOr, otLike, otEquals, otOrder, otAnd);

  TDefaultCriteria = class(TInterfacedObject, ICriteria)
  const
    OPERATORS: array [low(TOperatorType) .. High(TOperatorType)] of string = ('WHERE', 'OR', 'LIKE', '=',
      'ORDER BY', 'AND');
  private
    FQuery: TFDQuery;
  public
    procedure Where(AField: string); overload;
    procedure Where(AField: TField); overload;
    procedure Where(AValue: Boolean); overload;
    procedure &Or(AField: string); overload;
    procedure &Or(AField: TField); overload;
    procedure &And(AField: string); overload;
    procedure &And(AField: TField); overload;
    procedure Like(AValue: string);
    procedure &Equals(AValue: Int64); overload;
    procedure &Equals(AValue: Boolean); overload;
    procedure &Equals(AValue: string); overload;
    procedure Order(AField: TField);
    constructor Create(AQuery: TFDQuery);
  end;

  TManagerCriteria = class
  private
    FCriteria: ICriteria;
    function GetDrive(AQuery: TFDQuery): string;
    function GetInstanceCriteria(AQuery: TFDQuery): ICriteria;
  public
    constructor Create(AQuery: TFDQuery);
    destructor Destroy; override;
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

uses
  FireDAC.Stan.Intf, SysUtils;

{ TDefaultCriteria }

procedure TDefaultCriteria.&And(AField: string);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otAnd], AField]));
end;

procedure TDefaultCriteria.&And(AField: TField);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otAnd], AField.Origin]));
end;

procedure TDefaultCriteria.&Or(AField: string);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otOr], AField]));
end;

constructor TDefaultCriteria.Create(AQuery: TFDQuery);
begin
  FQuery := AQuery;
end;

procedure TDefaultCriteria.Equals(AValue: string);
const
  PHRASE = '%s ''%s''';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otEquals], AValue]));
end;

procedure TDefaultCriteria.Equals(AValue: Int64);
const
  PHRASE = '%s %d';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otEquals], AValue]));
end;

procedure TDefaultCriteria.Where(AField: TField);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otWhere], AField.Origin]));
end;

procedure TDefaultCriteria.Equals(AValue: Boolean);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otEquals], BoolToStr(AValue, True)]));
end;

procedure TDefaultCriteria.Like(AValue: string);
const
  PHRASE = '::text %s %s';
var
  LKeyParam: string;
  LParam: TFDParam;
begin
  LKeyParam := THashMD5.Create.HashAsString;
  FQuery.SQL.Text := FQuery.SQL.Text + format(PHRASE, [OPERATORS[otLike], ':' + LKeyParam]);
  LParam := FQuery.ParamByName(LKeyParam);
  LParam.DataType := ftString;
  LParam.Value := AValue;
end;

procedure TDefaultCriteria.Order(AField: TField);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otOrder], AField.Origin]));
end;

procedure TDefaultCriteria.Where(AField: string);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otWhere], AField]));
end;

procedure TDefaultCriteria.Where(AValue: Boolean);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otWhere], BoolToStr(AValue, True)]));
end;

procedure TDefaultCriteria.&Or(AField: TField);
const
  PHRASE = ' %s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otOr], AField.Origin]));
end;

{ TCriteria }

constructor TManagerCriteria.Create(AQuery: TFDQuery);
begin
  FCriteria := GetInstanceCriteria(AQuery);
end;

destructor TManagerCriteria.Destroy;
begin
  inherited;
end;

function TManagerCriteria.GetDrive(AQuery: TFDQuery): string;
var
  LDef: IFDStanConnectionDef;
begin
  Result := AQuery.Connection.DriverName;
  if Result.IsEmpty and not AQuery.Connection.ConnectionDefName.IsEmpty then
  begin
    LDef := FDManager.ConnectionDefs.FindConnectionDef(AQuery.Connection.ConnectionDefName);
    Result := LDef.Params.DriverID;
  end;
end;

function TManagerCriteria.GetInstanceCriteria(AQuery: TFDQuery): ICriteria;
var
  LCriteria: ICriteria;
begin
  LCriteria := nil;

  case AnsiIndexStr(GetDrive(AQuery), ['PG']) of
    0:
      LCriteria := TDefaultCriteria.Create(AQuery);
  else
      LCriteria := TDefaultCriteria.Create(AQuery);
  end;

  Result := LCriteria;
end;

end.
