unit Ragna.Criteria.Intf;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

type
  ICriteria = interface
    ['{BC7603D3-DB7D-4A61-AA73-E1152A933E07}']
    procedure Where(const AField: string);
    procedure &Or(const AField: string);
    procedure &And(const AField: string);
    procedure Like(const AValue: string);
    procedure &Equals(const AValue: Int64); overload;
    procedure &Equals(const AValue: Boolean); overload;
    procedure &Equals(const AValue: string); overload;
    procedure Order(const AField: string);
  end;

implementation

end.
