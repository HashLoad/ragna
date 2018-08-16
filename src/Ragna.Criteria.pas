unit Ragna.Criteria;

interface

uses
  FireDAC.Comp.Client, StrUtils, Ragna.Intf, Data.DB;

type

  TOperatorType = (otWhere, otOr, otLike, otEquals, otOrder);

  TPGCriteria = class(TInterfacedObject, ICriteria)
  const
    OPERATORS: array [low(TOperatorType) .. High(TOperatorType)
      ] of string = ('WHERE', 'OR', 'LIKE', '=', 'ORDER BY');
  private
    FQuery: TFDQuery;
  public
    procedure Where(AField: TField); overload;
    procedure Where(AValue: Boolean); overload;
    procedure &Or(AField: TField);
    procedure Like(AValue: string);
    procedure &Equals(AValue: Int64); overload;
    procedure &Equals(AValue: Boolean); overload;
    procedure Order(AField: TField);
    constructor Create(AQuery: TFDQuery);
  end;

  TManagerCriteria = class
  private
    FCriteria: ICriteria;
    function GetInstanceCriteria(AQuery: TFDQuery): ICriteria;
  public
    constructor Create(AQuery: TFDQuery);
    destructor Destroy; override;
    property Criteria: ICriteria read FCriteria write FCriteria;
  end;

implementation

uses SysUtils;

{ TPGCriteria }

constructor TPGCriteria.Create(AQuery: TFDQuery);
begin
  FQuery := AQuery;
end;

procedure TPGCriteria.Equals(AValue: Int64);
const
  PHRASE = '%s %d';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otEquals], AValue]));
end;

procedure TPGCriteria.Where(AField: TField);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otWhere], AField.Origin]));
end;

procedure TPGCriteria.Equals(AValue: Boolean);
const
  PHRASE = '%s %d';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otEquals], AValue]));
end;

procedure TPGCriteria.Like(AValue: string);
const
  PHRASE = '::text %s %s';
begin
  FQuery.SQL.Text := FQuery.SQL.Text +
    format(PHRASE, [OPERATORS[otLike], AValue]);
end;

procedure TPGCriteria.Order(AField: TField);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otOrder], AField.Origin]));
end;

procedure TPGCriteria.Where(AValue: Boolean);
const
  PHRASE = '%s %s';
begin
  FQuery.SQL.Add(format(PHRASE, [OPERATORS[otWhere], AValue]));
end;

procedure TPGCriteria.&Or(AField: TField);
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

function TManagerCriteria.GetInstanceCriteria(AQuery: TFDQuery): ICriteria;
var
  LCriteria: ICriteria;
begin
  LCriteria := nil;

  case AnsiIndexStr(AQuery.Connection.DriverName, ['PG']) of
    0:
      LCriteria := TPGCriteria.Create(AQuery);
  end;

  Result := LCriteria;
end;

end.
