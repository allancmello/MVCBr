unit TestMVCBr.View;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, system.SysUtils,
  system.Classes, VCL.Forms,
  MVCBr.Interf,
  MVCBr.Model,
  TestMVCBr.TestForm,
  MVCBr.Controller,
  TestSecondView,
  TestViewView,
  MVCBr.View,
  MVCBr.FormView,
  system.Rtti;

type
  // Test methods for class TViewFactory

  TestTViewFactory = class(TTestCase)
  strict private
    FViewFactory: TViewFactory;
    FController: IController;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestNew;
    procedure TestShowView;
    procedure TestUpdate;
    procedure TestGetController;
  end;
  // Test methods for class TFormFactory

  TestTFormFactory = class(TTestCase)
  strict private
    FFormFactory: ITestViewView;
    Controller: IController;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetController;
    procedure TestThis;
    procedure TestInvokeMethod;
    procedure TestInterfaceStubInt;
    procedure TestShowView;
    procedure TestUpdate;
    procedure TestResolveController;
    procedure TestEnviarEventoParaUmView;
    procedure TestEnviarEventoJSONparaUmView;
    procedure TestProcurarModelEmUmController;
    procedure TestFindController;
    procedure TestIsModel;
    procedure TestChamarViewSecundaria;

    procedure TestRegisterObserver;
    procedure TestUnRegisterObserverNamed;
    procedure TestUnRegisterObserverNamedOnly;
    procedure TesteObserver;

  end;

implementation

uses testSecond.Controller.Interf, TestView.Controller.Interf,
  MVCBr.ApplicationController, TestView.Controller, system.Json,
  test.Controller.Interf, test.Model.Interf;

procedure TestTViewFactory.SetUp;
begin
  FController := TControllerFactory.create;
  FViewFactory := TViewFactory.create;
  FController.View(FViewFactory);
  checkNotNull(FViewFactory);
end;

procedure TestTViewFactory.TearDown;
begin
  FController.release;
  FController := nil;
end;

procedure TestTViewFactory.TestNew;
var
  ReturnValue: IView;
  AController: IController;
  AClass: TViewFactoryClass;
begin
  // TODO: Setup method call parameters
  AController := TControllerFactory.create;
  ReturnValue := TViewFactory.New<IView>(TViewFactory);
  checkNotNull(ReturnValue);
  // TODO: Validate method results
end;

procedure TestTViewFactory.TestShowView;
var
  ReturnValue: Integer;
  AProc: TProc<IView>;
begin
  // TODO: Setup method call parameters
  ReturnValue := FViewFactory.ShowView(AProc);
  CheckTrue(ReturnValue >= 0);
  // TODO: Validate method results
end;

procedure TestTViewFactory.TestUpdate;
var
  ReturnValue: IView;
begin
  ReturnValue := FViewFactory.UpdateView;
  checkNotNull(ReturnValue);
  // TODO: Validate method results
end;

procedure TestTViewFactory.TestGetController;
var
  ReturnValue: IController;
begin
  ReturnValue := FViewFactory.GetController;
  // TODO: Validate method results
  checkNotNull(ReturnValue);
end;

procedure TestTFormFactory.SetUp;
begin
  Controller := TTestViewController.New(nil, nil);
  FFormFactory := Controller.GetView as ITestViewView;
end;

procedure TestTFormFactory.TearDown;
begin
  if assigned(Controller) then
    Controller.release;
  Controller := nil;
end;

procedure TestTFormFactory.TestGetController;
var
  ReturnValue: IController;
begin
  ReturnValue := FFormFactory.GetController;
  checkNotNull(ReturnValue);
  // TODO: Validate method results
end;

procedure TestTFormFactory.TestThis;
var
  ReturnValue: TObject;
begin
  ReturnValue := FFormFactory.This;
  checkNotNull(ReturnValue);
  // TODO: Validate method results
end;

Type
  TFormFactoryEx = class(TTesteFormView);

procedure TestTFormFactory.TestInterfaceStubInt;
var
  itf: ITestViewView;
begin
  itf := FFormFactory;
  CheckTrue(itf.getStubInt = 1, 'N�o obteve dados na interface');
end;

procedure TestTFormFactory.TestInvokeMethod;
var
  ReturnValue: Boolean;
begin
  // TODO: Setup method call parameters
  FFormFactory.PropertyValue['isShowModal'] := true;
  CheckTrue(TTestSecondView(FFormFactory.This).isShowModal,
    'N�o alterou o ShowModal');
  ReturnValue := TTestViewView(FFormFactory.This).InvokeMethod<Boolean>
    ('GetShowModalStub', []);
  CheckTrue(ReturnValue, 'N�o funcionou RTTI');
  // TODO: Validate method results
end;

procedure TestTFormFactory.TestIsModel;
begin
  CheckTrue(FFormFactory.GetController.IsModel(itestModel),
    'N�o achei IsModel');
end;

procedure TestTFormFactory.TestProcurarModelEmUmController;
var
  inf: itestModel;
  ctrl: ITestViewController;
begin
//  ApplicationController.SetMainView(FFormFactory);
//  checkNotNull(ApplicationController.MainView,
//    'N�o incializou o form principal');

  inf := FFormFactory.GetModel(itestModel) as itestModel;
  checkNotNull(inf, 'N�o encontrou o model instanciado no controller');
  inf := nil;

  ctrl := ApplicationController.ResolveController(ITestViewController)
    as ITestViewController;
  checkNotNull(ctrl, 'N�o encontrou o controller desejado');

  checkNotNull(ctrl.GetView, 'N�o incialicou o VIEW');

  inf := ctrl.GetModel(itestModel) as itestModel;
  checkNotNull(inf, 'N�o encontrou o model instanciado no controller');
  ctrl := nil;
  inf := nil;

end;

procedure TestTFormFactory.TestRegisterObserver;
var
  obs: IMVCBrObserver;
begin
  supports(FFormFactory.This, IMVCBrObserver, obs);
  TMVCBr.RegisterObserver('x', obs);
end;

procedure TestTFormFactory.TestResolveController;
var
  i: ITestController;
begin
  i := TTestSecondView(FFormFactory.This).ResolveController<ITestController> as ITestController;
  checkNotNull(i, 'N�o retornou a interface do controller');
  CheckTrue(i.This.InheritsFrom(TControllerFactory),
    'N�o herdou de TControllerFactory');
end;

procedure TestTFormFactory.TestShowView;
var
  ReturnValue: Integer;
  AProc: TProc<IView>;
begin
  // TODO: Setup method call parameters
  TTestSecondView(FFormFactory.This).isShowModal := false;
  ReturnValue := FFormFactory.ShowView(AProc);

  // TODO: Validate method results
end;

procedure TestTFormFactory.TestUnRegisterObserverNamed;
var
  obs: IMVCBrObserver;
begin
  supports(FFormFactory.This, IMVCBrObserver, obs);
  TMVCBr.RegisterObserver('x', obs);
  TMVCBr.UnRegisterObserver('x', obs);
end;

procedure TestTFormFactory.TestUnRegisterObserverNamedOnly;
var
  obs: IMVCBrObserver;
begin
  supports(FFormFactory.This, IMVCBrObserver, obs);
  TMVCBr.RegisterObserver('y', obs);
  TMVCBr.UnRegisterObserver('y');
end;

procedure TestTFormFactory.TestUpdate;
var
  ReturnValue: IView;
begin
  ReturnValue := FFormFactory.UpdateView;
  checkNotNull(ReturnValue);
  // TODO: Validate method results
end;

procedure TestTFormFactory.TestEnviarEventoParaUmView;
var
  inf: ITestViewView;
  LHandled: Boolean;
begin
  inf := FFormFactory;
  LHandled := false;
  inf.ViewEvent('teste.event', LHandled);
  CheckTrue(LHandled, 'N�o encontrou o evento');
end;

procedure TestTFormFactory.TesteObserver;
var
  obs: IMVCBrObserver;
  ref: Integer;
begin
  supports(FFormFactory.This, IMVCBrObserver, obs);
  TMVCBr.RegisterObserver('x', obs);
  ref := FFormFactory.getStubInt;
  TMVCBr.UpdateObserver('x', nil);

  CheckTrue(FFormFactory.getStubInt > ref, 'N�o chamou o evento do Observer');

  TMVCBr.UnRegisterObserver('x', obs);
  obs := nil;
end;

procedure TestTFormFactory.TestFindController;
begin
  checkNotNull(ApplicationController.FindController(ITestViewController),
    'N�o achou o controller com findController');
end;

procedure TestTFormFactory.TestChamarViewSecundaria;
var
  ctrl: IController;
  itf: ITestSecondView;
begin
  ctrl := ApplicationController.ResolveController(ITestSecondController);
  try
  checkNotNull(ctrl, 'N�o achei o segundo controller');
  checkNotNull(ctrl.GetView, 'N�o iniciou o segundo VEIW');

  itf := ctrl.GetView as ITestSecondView;
  CheckTrue(itf.GetStubString = 'test', 'N�o obteve GetStubString');

  finally
    //ctrl.release;
    //itf.release;
  end;
end;

procedure TestTFormFactory.TestEnviarEventoJSONparaUmView;
var
  inf: ITestViewView;
  LHandled: Boolean;
  j: TJsonObject;
begin
  inf := FFormFactory;
  LHandled := false;
  j := TJsonObject.create(TJsonPair.create('texto', 'test'));
  try
    inf.ViewEvent(j, LHandled);
  finally
    j.free;
  end;
  CheckTrue(LHandled, 'N�o encontrou o evento');
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTViewFactory.Suite);
RegisterTest(TestTFormFactory.Suite);

end.

