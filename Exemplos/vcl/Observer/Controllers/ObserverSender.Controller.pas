{//************************************************************//}
{//                                                            //}
{//         C�digo gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 18/06/2017 16:01:18                                  //}
{//************************************************************//}
 /// <summary>
 /// O controller possui as seguintes caracter�sticas:
 ///   - pode possuir 1 view associado  (GetView)
 ///   - pode receber 0 ou mais Model   (GetModel<Ixxx>)
 ///   - se auto registra no application controller
 ///   - pode localizar controller externos e instanci�-los
 ///     (resolveController<I..>)
 /// </summary>
unit ObserverSender.Controller;
 /// <summary>
 ///    Object Factory para implementar o Controller
 /// </summary>
interface
{.$I ..\inc\mvcbr.inc}
uses
System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}  VCL.Forms,{$endif}{$endif}
System.Classes, MVCBr.Interf,
MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
System.RTTI, ObserverSender.Controller.interf,
ObserverSenderView;
type
  TObserverSenderController = class(TControllerFactory,
    IObserverSenderController,
    IThisAs<TObserverSenderController>)
  protected
    Procedure DoCommand(ACommand: string;
        const AArgs: array of TValue); override;
  public
    // inicializar os m�dulos personalizados em CreateModules
    Procedure CreateModules;virtual;
    Constructor Create;override;
    Destructor Destroy; override;
 /// New Cria nova inst�ncia para o Controller
    class function New(): IController; overload;
    class function New(const AView: IView; const AModel: IModel)
      : IController; overload;
    class function New(const AModel: IModel): IController; overload;
    function ThisAs: TObserverSenderController;
 /// Init ap�s criado a inst�ncia � chamado para concluir init
    procedure init;override;
  end;
implementation
///  Creator para a classe Controller
Constructor TObserverSenderController.Create;
begin
 inherited;
  ///  Inicializar as Views...
    View(TObserverSenderView.New(self));
  ///  Inicializar os modulos
 CreateModules; //< criar os modulos persolnizados
end;
///  Finaliza o controller
Destructor TObserverSenderController.destroy;
begin
  inherited;
end;
///  Classe Function basica para criar o controller
class function TObserverSenderController.New(): IController;
begin
 result := new(nil,nil);
end;
///  Classe para criar o controller com View e Model criado
class function TObserverSenderController.New(const AView: IView;
   const AModel: IModel) : IController;
var
  vm: IViewModel;
begin
  result := TObserverSenderController.create as IController;
  result.View(AView).Add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
      begin
        vm.View(AView).Controller( result );
      end;
end;
///  Classe para inicializar o Controller com um Modulo inicialz.
class function TObserverSenderController.New(
   const AModel: IModel): IController;
begin
  result := new(nil,AModel);
end;
///  Cast para a interface local do controller
function TObserverSenderController.ThisAs: TObserverSenderController;
begin
   result := self;
end;
///  Executar algum comando customizavel
Procedure TObserverSenderController.DoCommand(ACommand: string;
   const AArgs:Array of TValue);
begin
    inherited;
end;
///  Evento INIT chamado apos a inicializacao do controller
procedure TObserverSenderController.init;
var ref:TObserverSenderView;
begin
  inherited;
 if not assigned(FView) then
 begin
   Application.CreateForm( TObserverSenderView, ref );
   supports(ref,IView,FView);
  {$ifdef FMX}
    if Application.MainForm=nil then
      Application.RealCreateForms;
  {$endif}
 end;
 AfterInit;
end;
/// Adicionar os modulos e MODELs personalizados
Procedure TObserverSenderController.CreateModules;
begin
   // adicionar os seus MODELs aqui
   // exemplo: add( MeuModel.new(self) );
end;
initialization
///  Inicializa��o automatica do Controller ao iniciar o APP
//TObserverSenderController.New(TObserverSenderView.New,TObserverSenderViewModel.New)).init();
///  Registrar Interface e ClassFactory para o MVCBr
  RegisterInterfacedClass(TObserverSenderController.ClassName,IObserverSenderController,TObserverSenderController);
finalization
///  Remover o Registro da Interface
  unRegisterInterfacedClass(TObserverSenderController.ClassName);
end.
