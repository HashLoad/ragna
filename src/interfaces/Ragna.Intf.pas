unit Ragna.Intf;

interface

uses FireDAC.Comp.Client, System.JSON, Data.DB;

type
  IRagna = interface
    ['{0F1AD1E9-A82C-44BE-9208-685B9C3C77F9}']
    procedure Paginate(const AOffSet, ALimit: Integer);
    procedure RadicalResearch(const AValue: string; const AFields: array of TField);
    procedure Remove(const AField: TField; const AValue: Int64);
    procedure FindById(const AField: TField; const AValue: Int64);
    procedure UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject);
    procedure New(const ABody: TJSONObject); overload;
    procedure New(const ABody: TJSONArray); overload;
    procedure OpenUp;
    procedure OpenEmpty;
    procedure Reset;
    procedure ToJson(out AJSON: TJSONArray); overload;
    procedure ToJson(out AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONArray); overload;
    function ToJSONArray: TJSONArray;
    function ToJSONObject: TJSONObject;
  end;

implementation

end.
