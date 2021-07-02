unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.FMTBcd, Data.DB, Data.SqlExpr,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmWKTeste = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    tblItensPedido: TFDMemTable;
    tblItensPedidocodigoProduto: TIntegerField;
    tblItensPedidodescricaoProduto: TStringField;
    tblItensPedidoquantidade: TFloatField;
    tblItensPedidovlrUnitario: TCurrencyField;
    tblItensPedidovlrTotal: TCurrencyField;
    qryAux: TFDQuery;
    qryLocProduto: TFDQuery;
    procedure tblItensPedidoBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tblItensPedidocodigoProdutoChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmWKTeste: TdmWKTeste;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmWKTeste.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnection1.Open();
    tblItensPedido.Open;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
  end;
end;

procedure TdmWKTeste.DataModuleDestroy(Sender: TObject);
begin
  tblItensPedido.Close;
  FDConnection1.Close;
end;

procedure TdmWKTeste.tblItensPedidoBeforePost(DataSet: TDataSet);
begin
  tblItensPedido.FieldByName('vlrTotal').AsCurrency := tblItensPedido.FieldByName('quantidade').AsFloat *
                                                       tblItensPedido.FieldByName('vlrUnitario').AsFloat;
end;

procedure TdmWKTeste.tblItensPedidocodigoProdutoChange(Sender: TField);
begin
  if Sender.IsNull then
    Exit;

  qryLocProduto.ParamByName('codigo').AsInteger := Sender.AsInteger;
  tblItensPedido.FieldByName('descricaoProduto').AsString := '';
  try
    qryLocProduto.Open();
    if qryLocProduto.IsEmpty then
    begin
      ShowMessage('Produto não localizado');
      Abort;
    end;
    tblItensPedido.FieldByName('descricaoProduto').AsString := qryLocProduto.FieldByName('descricao').AsString;
  finally
    qryLocProduto.Close;
  end;
end;

end.
