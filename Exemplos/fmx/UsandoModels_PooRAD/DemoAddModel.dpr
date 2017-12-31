program DemoAddModel;

// C�digo gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017
uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  DemoAddModel.Controller in 'Controllers\DemoAddModel.Controller.pas',
  DemoAddModel.Controller.Interf in 'Controllers\DemoAddModel.Controller.Interf.pas',
  DemoAddModelView in 'Views\DemoAddModelView.pas' {DemoAddModelView},
  produtos.Controller.Interf in 'Views\produtos.Controller.Interf.pas',
  produtos.Controller in 'Views\produtos.Controller.pas',
  produtosView in 'Views\produtosView.pas' {produtosView};

{$R *.res}
function CheckApplicationAuth: boolean;
begin
  // retornar True se o applicatio pode ser carregado
  //          False se n�o foi autorizado inicializa��o
  result := true;
end;

begin
if CheckApplicationAuth then
  ApplicationController.Run(TDemoAddModelController.New);
end.
