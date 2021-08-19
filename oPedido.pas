unit oPedido;

interface
  uses
    Vcl.StdCtrls;

  type
    TPedido = class
      private
        FLabel: TLabel;
        class var TotPedido: Double;
        class var codigoCliente: Integer;
      public
        constructor Create(lblTotal: TLabel);
        procedure Soma(valor: Double);
        procedure Subtrai(valor: Double);
        class property Total: Double read TotPedido write TotPedido;
        class property Cliente: Integer read codigoCliente write codigoCliente;
    end;

implementation

uses
  System.SysUtils;

constructor TPedido.Create(lblTotal: TLabel);
begin
  inherited Create;
  FLabel := lblTotal;
end;

procedure TPedido.Soma(valor: Double);
begin
  TotPedido := TotPedido + valor;
  if FLabel = nil then
    Exit;
  FLabel.Caption := FormatFloat('#,##0.00', TotPedido);
end;

procedure TPedido.Subtrai(valor: Double);
begin
  TotPedido := TotPedido - valor;
  if FLabel = nil then
    Exit;
  FLabel.Caption := FormatFloat('#,##0.00', TotPedido);
end;

end.
