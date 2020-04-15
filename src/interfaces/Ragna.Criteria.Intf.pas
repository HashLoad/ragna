unit Ragna.Criteria.Intf;

interface

uses Data.DB;

type
  ICriteria = interface
    ['{BC7603D3-DB7D-4A61-AA73-E1152A933E07}']
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
  end;

implementation

end.
