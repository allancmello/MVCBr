PROGRAM FMXBasico;

// C�digo gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017
uses
  System.StartUpCopy,
  FMX.Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  FMXBasico.Controller in 'FMXBasico.Controller.pas',
  FMXBasico.Controller.Interf in 'FMXBasico.Controller.Interf.pas',
  FMXBasico.ViewModel.Interf in 'FMXBasico.ViewModel.Interf.pas',
  FMXBasico.ViewModel in 'FMXBasico.ViewModel.pas',
  FMXBasicoView in 'FMXBasicoView.pas' {FMXBasicoView};

{$R *.res}
begin
  ApplicationController.Run(TFMXBasicoController.New,
    function :boolean
    begin
      // retornar True se o applicatio pode ser carregado
      //          False se n�o foi autorizado inicializa��o
      result := true;
    end);
end.
