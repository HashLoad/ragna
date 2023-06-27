unit Views.Samples;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
  FireDAC.VCLUI.Wait, Vcl.StdCtrls, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TFrmRagnaSamples = class(TForm)
    DBGrid1: TDBGrid;
    dsCountry: TDataSource;
    Country: TFDQuery;
    Button1: TButton;
    FDConnection: TFDConnection;
    CountryName: TWideStringField;
    CountryCapital: TWideStringField;
    CountryContinent: TWideStringField;
    CountryArea: TFloatField;
    CountryPopulation: TFloatField;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    mmJson: TMemo;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  end;

var
  FrmRagnaSamples: TFrmRagnaSamples;

implementation

{$R *.dfm}

uses Ragna;

procedure TFrmRagnaSamples.Button10Click(Sender: TObject);
begin
  Country
    .OpenUp
    .EditFromJson('{"name":"A","capital":"B","continent":"C","area":1,"population":2}');
end;

procedure TFrmRagnaSamples.Button1Click(Sender: TObject);
begin
  Country.OpenUp;
end;

procedure TFrmRagnaSamples.Button2Click(Sender: TObject);
begin
  Country.OpenEmpty;
end;

procedure TFrmRagnaSamples.Button3Click(Sender: TObject);
begin
  Country
    .Where(CountryName).Equals('Brazil')
    .&Or(CountryName).Equals('Canada')
    .OpenUp;
end;

procedure TFrmRagnaSamples.Button4Click(Sender: TObject);
begin
  Country
    .Where(CountryName).Equals('Brazil')
    .&And(CountryCapital).Equals('Brasilia')
    .OpenUp;
end;

procedure TFrmRagnaSamples.Button5Click(Sender: TObject);
begin
  Country
    .Where(CountryName).Like('B')
    .OpenUp;
end;

procedure TFrmRagnaSamples.Button6Click(Sender: TObject);
begin
  Country
    .Order(CountryName)
    .OpenUp;
end;

procedure TFrmRagnaSamples.Button7Click(Sender: TObject);
begin
  mmJson.Lines.Text := Country.OpenUp.ToJSONObject.ToString;
end;

procedure TFrmRagnaSamples.Button8Click(Sender: TObject);
begin
  mmJson.Lines.Text := Country.OpenUp.ToJSONArray.ToString;
end;

procedure TFrmRagnaSamples.Button9Click(Sender: TObject);
begin
  Country.New('{"name":"A","capital":"B","continent":"C","area":1,"population":2}');
end;

end.
