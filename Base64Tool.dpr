program Base64Tool;

uses
  Vcl.Forms,
  B64TMainFormUnit in 'B64TMainFormUnit.pas' {B64TMainForm},
  uAppFolder in 'uAppFolder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TB64TMainForm, B64TMainForm);
  Application.Run;
end.
