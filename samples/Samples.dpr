program Samples;

uses
  Vcl.Forms,
  Views.Samples in 'src\Views.Samples.pas' {FrmRagnaSamples},
  Ragna.Criteria.Impl in '..\src\core\Ragna.Criteria.Impl.pas',
  Ragna.Impl in '..\src\core\Ragna.Impl.pas',
  Ragna in '..\src\helpers\Ragna.pas',
  Ragna.Criteria.Intf in '..\src\interfaces\Ragna.Criteria.Intf.pas',
  Ragna.Intf in '..\src\interfaces\Ragna.Intf.pas',
  Ragna.State in '..\src\state\Ragna.State.pas',
  Ragna.Types in '..\src\types\Ragna.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmRagnaSamples, FrmRagnaSamples);
  Application.Run;
end.
