unit AlteraProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons;

type
  TfrmAlteraProduto = class(TForm)
    dsItensPedido: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsItensPedidoStateChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlteraProduto: TfrmAlteraProduto;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TfrmAlteraProduto.btnCancelarClick(Sender: TObject);
begin
  if (dmWKTeste.tblItensPedido.State in [dsEdit,dsInsert]) then
    dmWKTeste.tblItensPedido.Cancel;
end;

procedure TfrmAlteraProduto.btnGravarClick(Sender: TObject);
begin
  dmWKTeste.tblItensPedido.Post;
end;

procedure TfrmAlteraProduto.dsItensPedidoStateChange(Sender: TObject);
begin
  btnGravar.Enabled := (dsItensPedido.State in [dsEdit,dsInsert]);
end;

procedure TfrmAlteraProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
