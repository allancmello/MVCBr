{ //************************************************************// }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 03/03/2017                                           // }
{ //************************************************************// }
unit oData.Interf;

interface

uses System.Classes, System.SysUtils, System.JSON, OData.Packet;

Type

  IODataDecodeParams = interface;
  IODataParse = interface;

  IODataDecode = interface
    ['{E9DA95A9-534F-495E-9293-2657D4330D4C}']
    function Lock: IODataDecode;
    procedure UnLock;
    function GetParse: IODataParse;
    function This: TObject;
    procedure SetSelect(const Value: string);
    procedure SetFilter(const Value: string);
    procedure SetOrderBy(const Value: string);
    procedure SetSkip(const Value: integer);
    procedure SetExpand(const Value: string);
    procedure SetTop(const Value: integer);
    procedure SetFormat(const Value: string);
    procedure SetResource(const Value: string);
    procedure SetInLineCount(const Value: string);
    procedure SetSkipToken(const Value: string);
    function GetExpand: string;
    function GetFilter: string;
    function GetFormat: string;
    function GetInLineCount: string;
    function GetOrderBy: string;
    function GetResource: string;
    function GetSelect: string;
    function GetSkip: integer;
    function GetSkipToken: string;
    function GetTop: integer;
    procedure SetGroupBy(const Value: string);
    function GetGroupBy: string;
    function GetResourceParams: IODataDecodeParams;
    procedure SetSearch(const Value: string);
    function GetSearch: string;
    procedure Setdebug(const Value: string);
    function GetDebug: string;

    property Resource: string read GetResource write SetResource;
    property ResourceParams: IODataDecodeParams read GetResourceParams;
    function GetLevel(FLevel: integer; AAutoCreate: Boolean): IODataDecode;
    function hasChild: Boolean;
    function Child: IODataDecode;
    function newChild: IODataDecode;

    function hasExpand: Boolean;
    function ExpandItem(const idx: integer): IODataDecode;
    function newExpand(const ACollection: string): IODataDecode;
    function ExpandCount: integer;

    // define a list of fields
    property &Select: string read GetSelect write SetSelect;
    // define filter (aka where)
    property &Filter: string read GetFilter write SetFilter;
    property &Search: string read GetSearch write SetSearch;

    // define orderby
    property &OrderBy: string read GetOrderBy write SetOrderBy;
    property &GroupBy: string read GetGroupBy write SetGroupBy;
    // expands relation collections
    property &Expand: string read GetExpand write SetExpand;
    // format response  (suport only json for now)
    property &Format: string read GetFormat write SetFormat;
    // pagination
    property &Skip: integer read GetSkip write SetSkip;
    property &Top: integer read GetTop write SetTop;
    property &SkipToken: string read GetSkipToken write SetSkipToken;
    property &Count: string read GetInLineCount write SetInLineCount;
    property &Debug: string read GetDebug write Setdebug;

    function ToString: string;

  end;

  IODataDecodeParams = interface
    ['{F03C7F83-F379-4D27-AFC5-C6D85FC56DE0}']
    procedure AddPair(AKey: string; AValue: string);
    procedure AddOperator(const AOperator: string);
    procedure AddOperatorLink(const AOperatorLink: string);
    procedure Clear;
    function Count: integer;
    function ContainKey(AKey: string): Boolean;
    function KeyOfIndex(const idx: integer): string;
    function OperatorOfIndex(const idx: integer): string;
    function OperatorLinkOfIndex(const idx: integer): string;
    function ValueOfIndex(const idx: integer): string;
  end;

  IODataDialect = interface
    ['{812DB60E-64D7-4290-99DB-F625EC52C6DA}']
    procedure Release;
    function GetResource: IInterface; overload;
    function createGETQuery(AValue: IODataDecode; AFilter: string;
      const AInLineCount: Boolean = false): string;
    function createDeleteQuery(oData: IODataDecode; AJsonBody: TJsonValue;
      AKeys: string): string;
    function CreatePostQuery(oData: IODataDecode;
      AJsonBody: TJsonValue): String;
    function createPATCHQuery(oData: IODataDecode; AJsonBody: TJsonValue;
      AKeys: string): String;
    function GetResource(AResource: string): IInterface; overload;
    function AfterCreateSQL(var SQL: string): Boolean;
  end;

  IODataParse = interface
    ['{10893BDD-CE9A-4F31-BB2E-8DF18EA5A91B}']
    procedure Parse(URL: string);
    procedure Release;
    function GetOData: IODataDecode;
    property oData: IODataDecode read GetOData; // write SetOData;
  end;

  IODataBase = interface
    ['{61D854AF-4773-4DD2-9648-AD93A4134F13}']
    procedure DecodeODataURL(CTX: TObject);
    function This: TObject;
    procedure Release;

    function ExecuteGET(AJsonBody: TJsonValue;
      var JSONResponse: TJSONObject): TObject;
    function ExecuteDELETE(ABody: string;
      var JSONResponse: TJSONObject): integer;
    function ExecutePOST(ABody: string; var JSON: TJSONObject): integer;
    function ExecutePATCH(ABody: string; var JSON: TJSONObject): integer;
    function ExecuteOPTIONS(var JSON: TJSONObject): integer;

    procedure CreateExpandCollections(AQuery: TObject);
    function Collection: string;
    function GetInLineRecordCount: integer;
    procedure SetInLineRecordCount(const Value: integer);
    property InLineRecordCount: integer read GetInLineRecordCount
      Write SetInLineRecordCount;
    function GetParse: IODataParse;
  end;

function GetODataConfigFilePath: string;
procedure SetODataConfigFilePath(APath: string);

implementation

uses {$IFDEF MSWINDOWS} WinApi.Windows, Registry, {$ENDIF} System.IniFiles;

var
  FConfigFilePath: string;

{$IFDEF MSWINDOWS}

function GetProgramFilesDir: String;
begin
  with TRegistry.create(KEY_QUERY_VALUE) do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion', True);
    result := ReadString('ProgramFilesDir');
    free;
  end;
end;
{$ENDIF}

procedure SetODataConfigFilePath(APath: string);
begin
  FConfigFilePath := APath;
end;

function GetODataConfigFilePath: string;
begin
  if FConfigFilePath = '' then
  begin
    FConfigFilePath := GetEnvironmentVariable('MVCBr');
    if FConfigFilePath = '' then
    begin
      FConfigFilePath := ExtractFilePath(ParamStr(0));
{$IFDEF MSWINDOWS}
      if not fileExists(FConfigFilePath + 'MVCBrServer.Config') then
        FConfigFilePath := GetProgramFilesDir + '\';
{$ENDIF}
      FConfigFilePath := FConfigFilePath + 'MVCBr\';
      ForceDirectories(FConfigFilePath);
    end;
  end;
  result := FConfigFilePath;
end;

Initialization

FConfigFilePath := '';

end.
