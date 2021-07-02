object frmAlteraProduto: TfrmAlteraProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alterar Item'
  ClientHeight = 174
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  DesignSize = (
    446
    174)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 78
    Height = 13
    Caption = 'C'#243'digo Produto:'
  end
  object DBText1: TDBText
    Left = 152
    Top = 38
    Width = 281
    Height = 17
    DataField = 'descricaoProduto'
    DataSource = dsItensPedido
  end
  object Label2: TLabel
    Left = 16
    Top = 62
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object Label3: TLabel
    Left = 152
    Top = 62
    Width = 68
    Height = 13
    Caption = 'Valor Unit'#225'rio:'
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 35
    Width = 121
    Height = 21
    DataField = 'codigoProduto'
    DataSource = dsItensPedido
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 81
    Width = 121
    Height = 21
    DataField = 'quantidade'
    DataSource = dsItensPedido
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 152
    Top = 81
    Width = 121
    Height = 21
    DataField = 'vlrUnitario'
    DataSource = dsItensPedido
    TabOrder = 2
  end
  object btnGravar: TBitBtn
    Left = 178
    Top = 124
    Width = 121
    Height = 37
    Anchors = [akTop, akRight]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnGravarClick
    ExplicitLeft = 192
  end
  object btnCancelar: TBitBtn
    Left = 317
    Top = 124
    Width = 121
    Height = 37
    Anchors = [akTop, akRight]
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnCancelarClick
    ExplicitLeft = 331
  end
  object dsItensPedido: TDataSource
    DataSet = dmWKTeste.tblItensPedido
    OnStateChange = dsItensPedidoStateChange
    Left = 376
    Top = 16
  end
end
