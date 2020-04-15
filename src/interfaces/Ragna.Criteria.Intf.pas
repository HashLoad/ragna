unit Ragna.Criteria.Intf;

interface

uses Data.DB;

type
  ICriteria = interface
    ['{BC7603D3-DB7D-4A61-AA73-E1152A933E07}']
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
  end;

implementation

end.
