unit Samples.Criteria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef;

type
  TSampleCriteria = class(TForm)
    FDQuery: TFDQuery;
    FDConnection: TFDConnection;
    FDQueryid: TLargeintField;
    FDQueryname: TWideStringField;
    FDQuerycnpj: TWideStringField;
    FDQuerysponsor_name: TWideStringField;
    FDQuerysponsor_email: TWideStringField;
    FDQuerysponsor_phone: TWideStringField;
    FDQueryobservation: TDataSetField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SampleCriteria: TSampleCriteria;

implementation

{$R *.dfm}

end.
