unit Ragna.Intf;

interface

uses FireDAC.Comp.Client, System.JSON, Data.DB;

type
  IRagna = interface
    ['{0F1AD1E9-A82C-44BE-9208-685B9C3C77F9}']
    procedure Paginate(AOffSet, ALimit: Integer);
    procedure RadicalResearch(AValue: string; AFields: array of TField);
    procedure Remove(AField: TField; AValue: Int64);
    procedure FindById(AField: TField; AValue: Int64);
    procedure UpdateById(AField: TField; AValue: Int64; ABody: TJSONObject);
    procedure New(ABody: TJSONObject); overload;
    procedure New(ABody: TJSONArray); overload;
    procedure OpenUp;
    procedure StartCriteria; deprecated;
    procedure EndCriteria; deprecated;
    procedure Reset;
    procedure ToJson(out AJSON: TJSONArray); overload;
    procedure ToJson(out AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONObject);
  end;

implementation

end.
