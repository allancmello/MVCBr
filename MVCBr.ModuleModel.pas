///
/// MVCBr.ModuleModel - Inherits from TDataModule to implements a Model Factory
/// Auth:  amarildo lacerda
/// Date:  mar/2017

{
  Changes:

}
unit MVCBr.ModuleModel;

interface

uses
{$IFDEF FMX} FMX.Forms, {$ELSE} VCL.Forms, VCL.Graphics, {$ENDIF} System.UITypes, System.SysUtils, System.Classes,
  MVCBr.ApplicationController, MVCBr.Interf {$ifndef BPL},
{$IFDEF FMX}MVCBr.FMX.DataModuleDummy{$ELSE} MVCBr.VCL.DataModuleDummy{$ENDIF}{$endif};

type
  // TModuleFactory = class({$IFDEF BPL}TDataModule, {$ELSE} TForm,
  // {$ENDIF} IModuleModel, IModel)
  TModuleFactory = class( {$IFDEF BPL}TDataModule, {$ELSE}  TDataModuleDummy,{$endif} IModuleModel, IModel)
  private
    { Private declarations }
    FController: IController;
    FID: string;
    FModelTypes: TModelTypes;
  protected
    function This: TObject; virtual;
    function GetID: string; virtual;
    function ID(const AID: String): IModel; virtual;
    function Update: IModel; virtual;

    function Controller(const AController: IController): IModel; virtual;
    function GetModelTypes: TModelTypes; virtual;
    function GetController: IController;
    procedure SetModelTypes(const AModelType: TModelTypes);
    property ModelTypes: TModelTypes read GetModelTypes write SetModelTypes;
    procedure AfterInit; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ApplicationControllerInternal: IApplicationController; virtual;
    function ApplicationController: TApplicationController; virtual;

  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{ .$R *.dfm }
{ TModuleFactory }

procedure TModuleFactory.AfterInit;
begin
  // chamado apos INIT;
end;

function TModuleFactory.ApplicationController: TApplicationController;
begin
  result := TApplicationController(ApplicationControllerInternal.This);
end;

function TModuleFactory.ApplicationControllerInternal: IApplicationController;
begin
  result := MVCBr.ApplicationController.ApplicationController;
end;

function TModuleFactory.Controller(const AController: IController): IModel;
begin
  result := self as IModel;
  FController := AController;
end;

constructor TModuleFactory.Create(AOwner: TComponent);
begin
  inherited;
  // BorderIcons:=[];
  // FFont:= TFont.Create;
end;

destructor TModuleFactory.destroy;
begin
  // FFont.Free;
  inherited;
end;

function TModuleFactory.GetController: IController;
begin
  result := FController;
end;

function TModuleFactory.GetID: string;
begin
  result := FID;
end;

function TModuleFactory.GetModelTypes: TModelTypes;
begin
  result := FModelTypes;
end;

function TModuleFactory.ID(const AID: String): IModel;
begin
  result := self as IModel;
  FID := AID;
end;



procedure TModuleFactory.SetModelTypes(const AModelType: TModelTypes);
begin
  FModelTypes := AModelType;
end;

function TModuleFactory.This: TObject;
begin
  result := self;
end;

function TModuleFactory.Update: IModel;
begin
  result := self as IModel;
end;

initialization

end.
