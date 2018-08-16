program criteria;

uses
  Vcl.Forms,
  Samples.Criteria in 'Samples.Criteria.pas' {SampleCriteria},
  Ragna.Criteria in '..\..\src\Ragna.Criteria.pas',
  Ragna in '..\..\src\Ragna.pas',
  Ragna.Impl in '..\..\src\Ragna.Impl.pas',
  Ragna.State in '..\..\src\Ragna.State.pas',
  DataSetConverter4D.Helper in '..\..\modules\DataSetConverter4Delphi\src\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\..\modules\DataSetConverter4Delphi\src\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\..\modules\DataSetConverter4Delphi\src\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\..\modules\DataSetConverter4Delphi\src\DataSetConverter4D.Util.pas',
  Ragna.Intf in '..\..\src\Ragna.Intf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSampleCriteria, SampleCriteria);
  Application.Run;
end.
