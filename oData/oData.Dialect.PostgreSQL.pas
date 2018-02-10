{
   Suporte ao dialeto PostgreSQL
}
{//************************************************************//}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 03/03/2017                                           //}
{//************************************************************//}

{
  Coder:
     28/04/2017 - Elis�ngela - @JaguariMirim

  Altera��es:
      - 16/05/2017 introduzido TopCmdAfterAtEndOfStmt por suporte a $top e $skip por indica��o
        da Elis�ngela;
}


unit oData.Dialect.PostgreSQL;

interface

uses System.Classes, System.SysUtils, oData.Interf, oData.Dialect;

type
  TODataDialectPostgreSQL = class(TODataDialect)
  private
    function TopCmdAfterSelectStmt(nTop, nSkip: integer): string; override;
    function TopCmdAfterFromStmt(nTop, nSkip: integer): string; override;
    function TopCmdAfterAtEndOfStmt(nTop, nSkip: integer): string; override;

    function TopCmdStmt: string; override;
    function SkipCmdStmt: string; override;
  public
    function createGETQuery(oData: TODataDecodeAbstract; AFilter: string;
      const AInLineCount: Boolean = false): string; override;
  end;

implementation

{ TODataDialectMySQL }

function TODataDialectPostgreSQL.createGETQuery(oData: TODataDecodeAbstract; AFilter: string;
  const AInLineCount: Boolean): string;
begin
  result := inherited;
end;

function TODataDialectPostgreSQL.SkipCmdStmt: string;
begin
  result := ' offset ';
end;

function TODataDialectPostgreSQL.TopCmdAfterAtEndOfStmt(nTop,
  nSkip: integer): string;
begin
   CreateTopSkip(result,nTop,nSkip);
end;

function TODataDialectPostgreSQL.TopCmdAfterFromStmt(nTop,
  nSkip: integer): string;
begin
  result := '';
end;

function TODataDialectPostgreSQL.TopCmdAfterSelectStmt(nTop,
  nSkip: integer): string;
begin
  result := '';
end;

function TODataDialectPostgreSQL.TopCmdStmt: string;
begin
  result := ' limit ';
end;

end.
