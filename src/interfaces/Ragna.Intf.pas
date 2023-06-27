unit Ragna.Intf;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses FireDAC.Comp.Client, System.JSON, Data.DB;

type
  IRagna = interface
    ['{0F1AD1E9-A82C-44BE-9208-685B9C3C77F9}']
    procedure Paginate(const AOffSet, ALimit: Integer);
    procedure RadicalResearch(const AValue: string; const AFields: array of TField);
    procedure Remove(const AField: TField; const AValue: Int64); overload;
    procedure Remove(const AField: TField; const AValue: string; const AGuid: Boolean = False); overload;
    procedure Remove(const AField: TField; const AValue: TGuid); overload;
    procedure FindById(const AField: TField; const AValue: TGuid); overload;
    procedure FindById(const AField: TField; const AValue: Int64); overload;
    procedure FindById(const AField: TField; const AValue: string; const AGuid: Boolean = False); overload;
    procedure UpdateById(const AField: TField; const AValue: Int64; const ABody: TJSONObject); overload;
    procedure UpdateById(const AField: TField; const AValue: string; const ABody: TJSONObject; const AGuid: Boolean = False); overload;
    procedure UpdateById(const AField: TField; const AValue: TGuid; const ABody: TJSONObject); overload;
    procedure OpenUp;
    procedure OpenEmpty;
    procedure Reset;
    procedure EditFromJson(const AJSON: TJSONObject); overload;
    procedure EditFromJson(const AJSON: TJSONArray); overload;
    procedure EditFromJson(const AJSON: string); overload;
    procedure New(const ABody: TJSONObject); overload;
    procedure New(const ABody: TJSONArray); overload;
    procedure New(const ABody: string); overload;
    function ToJSONArray: TJSONArray;
    function ToJSONObject: TJSONObject;
  end;

implementation

end.
