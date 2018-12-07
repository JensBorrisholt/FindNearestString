program TEST;

uses
  Vcl.Forms,
  MainU in 'MainU.pas' {FormMain},
  FindNearestStringU in 'FindNearestStringU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
