program WKTeste;

uses
  Vcl.Forms,
  Pedidos in 'Pedidos.pas' {frmPedidos},
  DataModule in 'DataModule.pas' {dmWKTeste: TDataModule},
  oPedido in 'oPedido.pas',
  AlteraProduto in 'AlteraProduto.pas' {frmAlteraProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TdmWKTeste, dmWKTeste);
  Application.Run;
end.
