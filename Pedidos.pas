unit Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, Data.DBXMySQL, Data.SqlExpr, Data.FMTBcd,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, oPedido, System.UITypes;

type
  TfrmPedidos = class(TForm)
    Label1: TLabel;
    edtCodigoCliente: TLabeledEdit;
    edtCodigoProduto: TLabeledEdit;
    edtQuantidade: TLabeledEdit;
    edtValorUnitario: TLabeledEdit;
    dsItensPedido: TDataSource;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    btnInsereProduto: TBitBtn;
    btnGravar: TBitBtn;
    btnCarregaPedido: TBitBtn;
    btnCancelarPedido: TBitBtn;
    lblNomeCliente: TLabel;
    lblTotal: TLabel;
    Label3: TLabel;
    lblNumPedido: TLabel;
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnInsereProdutoClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnCarregaPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure Reset;
    procedure ExcluirItemProduto;
  public
    { Public declarations }
    objPedido: TPedido;
  end;

var
  frmPedidos: TfrmPedidos;

implementation

uses
  DataModule, AlteraProduto;

{$R *.dfm}

procedure TfrmPedidos.btnCancelarPedidoClick(Sender: TObject);
var
  numPedido: String;
begin
  if not InputQuery('Cancelamento de Pedido', 'Número do Pedido', numPedido) then
    Exit;

  with dmWKTeste.qryAux.SQL do
  begin
    Clear;
    Add('SELECT numeroPedido FROM pedidosdadosgerais');
    Add('WHERE numeroPedido = ' + numPedido);
  end;

  try
    dmWKTeste.qryAux.Open();
    if dmWKTeste.qryAux.IsEmpty then
    begin
      ShowMessage('Pedido numero ' + numPedido + ' não foi localizado.');
      Exit;
    end;
  finally
    dmWKTeste.qryAux.Close;
  end;

  if MessageDlg('Deseja cancelar o Pedido ' + numPedido + '?', mtConfirmation, [mbYES, mbNO], 0) <> mrYes then
    Exit;

  dmWKTeste.FDConnection1.StartTransaction;
  try
    dmWKTeste.FDConnection1.ExecSQL('DELETE FROM pedidosprodutos WHERE numeroPedido = ' + numPedido);
    dmWKTeste.FDConnection1.ExecSQL('DELETE FROM pedidosdadosgerais WHERE numeroPedido = ' + numPedido);
    dmWKTeste.FDConnection1.Commit;
    ShowMessage('Pedido número ' + numPedido + ' foi cancelado.');
  except
    on E: Exception do
    begin
      dmWKTeste.FDConnection1.Rollback;
      ShowMessage('Erro ao gravar os dados: ' + E.Message);
    end;
  end;
end;

procedure TfrmPedidos.btnCarregaPedidoClick(Sender: TObject);
var
  numPedido: String;
begin
  if not InputQuery('Carregar Pedido', 'Número do Pedido', numPedido) then
    Exit;

  with dmWKTeste.qryAux.SQL do
  begin
    Clear;
    Add('SELECT numeroPedido, codigoCliente, valorTotal');
    Add(', clientes.nome');
    Add('FROM pedidosdadosgerais');
    Add('INNER JOIN clientes ON clientes.codigo = pedidosdadosgerais.codigoCliente');
    Add('WHERE numeroPedido = ' + numPedido);
  end;

  try
    dmWKTeste.qryAux.Open();
    if dmWKTeste.qryAux.IsEmpty then
    begin
      ShowMessage('Pedido numero ' + numPedido + ' não foi localizado.');
      Exit;
    end;

    lblNumPedido.Caption := dmWKTeste.qryAux.FieldByName('numeroPedido').AsString;
    objPedido.Cliente := dmWKTeste.qryAux.FieldByName('codigoCliente').AsInteger;
    objPedido.Total := dmWKTeste.qryAux.FieldByName('valorTotal').AsFloat;
    edtCodigoCliente.Text := dmWKTeste.qryAux.FieldByName('codigoCliente').AsString;
    lblTotal.Caption := FormatFloat('#,##0.00', dmWKTeste.qryAux.FieldByName('valorTotal').AsFloat);
    lblNomeCliente.Caption := dmWKTeste.qryAux.FieldByName('nome').AsString;

    dmWKTeste.tblItensPedido.EmptyDataSet;
    dmWKTeste.qryAux.Close;
    with dmWKTeste.qryAux.SQL do
    begin
      Clear;
      Add('SELECT quantidade, valorUnitario, valorTotal, codigoProduto');
      Add(', produtos.descricao');
      Add('FROM pedidosprodutos');
      Add('INNER JOIN produtos ON produtos.codigo = pedidosprodutos.codigoProduto');
      Add('WHERE numeroPedido = ' + numPedido);
    end;
    dmWKTeste.qryAux.Open();
    while not dmWKTeste.qryAux.Eof do
    begin
      dmWKTeste.tblItensPedido.Append;
      dmWKTeste.tblItensPedido.FieldByName('codigoProduto').AsInteger := dmWKTeste.qryAux.FieldByName('codigoProduto').AsInteger;
      dmWKTeste.tblItensPedido.FieldByName('descricaoProduto').AsString := dmWKTeste.qryAux.FieldByName('descricao').AsString;
      dmWKTeste.tblItensPedido.FieldByName('vlrUnitario').AsCurrency := dmWKTeste.qryAux.FieldByName('valorUnitario').AsCurrency;
      dmWKTeste.tblItensPedido.FieldByName('quantidade').AsFloat := dmWKTeste.qryAux.FieldByName('quantidade').AsFloat;
      dmWKTeste.tblItensPedido.Post;
      dmWKTeste.qryAux.Next;
    end;
  finally
    dmWKTeste.qryAux.Close;
    edtCodigoCliente.SetFocus;
  end;
end;

procedure TfrmPedidos.btnGravarClick(Sender: TObject);
var
  numPedido: Integer;
  sSQL: String;
  format: TFormatSettings;
begin
  if not dmWKTeste.FDConnection1.Connected then
    Exit;

  if dmWKTeste.tblItensPedido.RecordCount = 0 then
  begin
    edtCodigoProduto.SetFocus;
    ShowMessage('Nenhum produto incluido');
    Exit;
  end;

  // Cliente não selecionado ...
  if objPedido.Cliente < 1 then
  begin
    edtCodigoCliente.SetFocus;
    ShowMessage('Cliente não selecionado');
    Exit;
  end;

  format.DecimalSeparator := '.';
  format.ThousandSeparator := #0;

  with dmWKTeste do
  begin
    with qryAux.SQL do
    begin
      Clear;
      Add('SELECT ifnull(max(numeroPedido) + 1, 1) AS id FROM pedidosdadosgerais');
    end;
    qryAux.Open();
    numPedido := qryAux.FieldByName('id').AsInteger;
    qryAux.Close;
    lblNumPedido.Caption := IntToStr(numPedido);

    FDConnection1.StartTransaction;
    try
      sSQL :=
        'INSERT INTO pedidosdadosgerais (dataEmissao, numeroPedido, valorTotal, codigoCliente) ' +
        'VALUES (NOW(), ' +
        IntToStr(numPedido) + ', ' +
        FloatToStr(objPedido.Total, format) + ', ' +
        IntToStr(objPedido.Cliente) + ')';
      FDConnection1.ExecSQL(sSQL);

      tblItensPedido.First;
      while not tblItensPedido.Eof do
      begin
        FDConnection1.ExecSQL('INSERT INTO pedidosprodutos ' +
              '(numeroPedido, quantidade, valorUnitario, valorTotal, codigoProduto) VALUES (' +
              IntToStr(numPedido) + ', ' +
              tblItensPedido.FieldByName('quantidade').AsString + ', ' +
              FloatToStr(tblItensPedido.FieldByName('vlrUnitario').AsFloat, format) + ', ' +
              FloatToStr(tblItensPedido.FieldByName('vlrTotal').AsFloat, format) + ', ' +
              tblItensPedido.FieldByName('codigoProduto').AsString + ')');
        tblItensPedido.Next;
      end;
      FDConnection1.Commit;
      ShowMessage('Pedido gravado com sucesso!');
      edtCodigoCliente.SetFocus;
    except
      on E: Exception do
      begin
        FDConnection1.Rollback;
        ShowMessage('Erro ao gravar os dados: ' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmPedidos.btnInsereProdutoClick(Sender: TObject);
var
  fQtd,
  fVlrUnit: Double;
begin
  if not dmWKTeste.FDConnection1.Connected then
    Exit;

  if edtCodigoProduto.Text = '' then
    Exit;

  // Cliente não selecionado ...
  if objPedido.Cliente < 1 then
  begin
    edtCodigoCliente.SetFocus;
    ShowMessage('Cliente não selecionado');
    Exit;
  end;

  with dmWKTeste.qryAux.SQL do
  begin
    Clear;
    Add('SELECT codigo, descricao, precoVenda FROM produtos');
    Add('WHERE codigo = ' + edtCodigoProduto.Text);
  end;

  try
    with dmWKTeste do
    begin
      qryAux.Open();

      if edtQuantidade.Text = '' then
        fQtd := 1
      else
        fQtd := StrToFloat(edtQuantidade.Text);

      if edtValorUnitario.Text = '' then
        fVlrUnit := qryAux.FieldByName('precoVenda').AsCurrency
      else
        fVlrUnit := StrToFloat(edtValorUnitario.Text);

      if qryAux.IsEmpty then
      begin
        ShowMessage('Produto código ' + edtCodigoProduto.Text + ' não foi localizado.');
        Exit;
      end;

      tblItensPedido.Append;
      tblItensPedido.FieldByName('codigoProduto').AsInteger := qryAux.FieldByName('codigo').AsInteger;
      // A descrição do produto é carregada no evento onChange do campo 'codigoProduto'
      tblItensPedido.FieldByName('vlrUnitario').AsCurrency := fVlrUnit;
      tblItensPedido.FieldByName('quantidade').AsFloat := fQtd;
      tblItensPedido.Post;
      objPedido.Soma(tblItensPedido.FieldByName('vlrTotal').AsFloat);
    end;

    edtCodigoProduto.Clear;
    edtQuantidade.Clear;
    edtValorUnitario.Clear;
    edtCodigoProduto.SetFocus;
  finally
    dmWKTeste.qryAux.Close;
  end;
end;

procedure TfrmPedidos.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
    ExcluirItemProduto
  else if (Key = VK_RETURN) then
  begin
    try
      objPedido.Subtrai(dmWKTeste.tblItensPedido.FieldByName('vlrTotal').AsFloat);
      Application.CreateForm(TfrmAlteraProduto, frmAlteraProduto);
      frmAlteraProduto.ShowModal;
      objPedido.Soma(dmWKTeste.tblItensPedido.FieldByName('vlrTotal').AsFloat);
    finally
      FreeAndNil(frmAlteraProduto);
    end;
  end;
end;

procedure TfrmPedidos.edtCodigoClienteChange(Sender: TObject);
begin
  btnCarregaPedido.Visible := (edtCodigoCliente.Text = '');
  btnCancelarPedido.Visible := (edtCodigoCliente.Text = '');
end;

procedure TfrmPedidos.edtCodigoClienteExit(Sender: TObject);
begin
  Reset;

  if not dmWKTeste.FDConnection1.Connected then
    Exit;

  if edtCodigoCliente.Text = '' then
    Exit;

  with dmWKTeste.qryAux.SQL do
  begin
    Clear;
    Add('SELECT codigo, nome FROM clientes');
    Add('WHERE codigo = ' + edtCodigoCliente.Text);
  end;

  try
    with dmWKTeste do
    begin
      qryAux.Open();
      if qryAux.IsEmpty then
      begin
        ShowMessage('Cliente código ' + edtCodigoCliente.Text + ' não foi localizado.');
        Exit;
      end;

      // Inicia um novo Pedido ...
      objPedido.Cliente := qryAux.FieldByName('codigo').AsInteger;
      lblNomeCliente.Caption := qryAux.FieldByName('nome').AsString;
    end;

  finally
    dmWKTeste.qryAux.Close;
  end;
end;

procedure TfrmPedidos.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
var
  sText: String;
begin
  sText := (Sender as TLabeledEdit).Text;
  if not (Key in ['0'..'9', #8]) then
  begin
    if (Key = '.') and (Pos(',', sText) = 0) then
      Key := ','
    else if (Key = ',') and (Pos(',', sText) = 0) then
      Key := ','
    else
      key := #0;
  end;

end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  objPedido := TPedido.Create(lblTotal);
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  Reset;
  edtCodigoCliente.SetFocus;
end;

procedure TfrmPedidos.Reset;
begin
  lblNomeCliente.Caption := '';
  objPedido.Cliente := 0;
  objPedido.Total := 0;
  dmWKTeste.tblItensPedido.EmptyDataSet;
  lblTotal.Caption := '0';
  lblNumPedido.Caption := '---';
  edtCodigoProduto.Clear;
  edtQuantidade.Clear;
  edtValorUnitario.Clear;
end;

procedure TfrmPedidos.ExcluirItemProduto;
begin
  if MessageDlg('Deseja excluir este produto?', mtConfirmation, [mbYES, mbNO], 0) <> mrYes then
    Exit;

  objPedido.Subtrai(dmWKTeste.tblItensPedido.FieldByName('vlrTotal').AsFloat);
  dmWKTeste.tblItensPedido.Delete;
end;

end.
