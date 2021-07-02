object frmPedidos: TfrmPedidos
  Left = 0
  Top = 0
  Caption = 'Teste DEV Delphi - Pedidos de Venda'
  ClientHeight = 499
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    674
    499)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 150
    Height = 23
    Caption = 'Pedidos de Venda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 176
    Width = 29
    Height = 13
    Caption = 'Itens:'
  end
  object lblNomeCliente: TLabel
    Left = 143
    Top = 83
    Width = 70
    Height = 13
    Caption = 'lblNomeCliente'
  end
  object lblTotal: TLabel
    Left = 594
    Top = 471
    Width = 53
    Height = 19
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'lblTotal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 472
    Top = 471
    Width = 42
    Height = 19
    Anchors = [akTop, akRight]
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblNumPedido: TLabel
    Left = 548
    Top = 19
    Width = 99
    Height = 19
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'lblNumPedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtCodigoCliente: TLabeledEdit
    Left = 16
    Top = 80
    Width = 121
    Height = 21
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo Cliente:'
    NumbersOnly = True
    TabOrder = 0
    OnChange = edtCodigoClienteChange
    OnExit = edtCodigoClienteExit
  end
  object edtCodigoProduto: TLabeledEdit
    Left = 16
    Top = 136
    Width = 121
    Height = 21
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo Produto:'
    NumbersOnly = True
    TabOrder = 1
  end
  object edtQuantidade: TLabeledEdit
    Left = 143
    Top = 136
    Width = 121
    Height = 21
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Quantidade:'
    NumbersOnly = True
    TabOrder = 2
  end
  object edtValorUnitario: TLabeledEdit
    Left = 270
    Top = 136
    Width = 121
    Height = 21
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor Unit'#225'rio:'
    TabOrder = 3
    OnKeyPress = edtValorUnitarioKeyPress
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 195
    Width = 648
    Height = 270
    DataSource = dsItensPedido
    DrawingStyle = gdsGradient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'codigoProduto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricaoProduto'
        Width = 326
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlrUnitario'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlrTotal'
        Visible = True
      end>
  end
  object btnInsereProduto: TBitBtn
    Left = 408
    Top = 120
    Width = 121
    Height = 37
    Caption = 'Inserir Produto'
    TabOrder = 5
    OnClick = btnInsereProdutoClick
  end
  object btnGravar: TBitBtn
    Left = 543
    Top = 120
    Width = 121
    Height = 37
    Caption = 'Gravar Pedido'
    TabOrder = 6
    OnClick = btnGravarClick
  end
  object btnCarregaPedido: TBitBtn
    Left = 408
    Top = 64
    Width = 121
    Height = 37
    Caption = 'Carregar Pedido'
    TabOrder = 7
    OnClick = btnCarregaPedidoClick
  end
  object btnCancelarPedido: TBitBtn
    Left = 545
    Top = 64
    Width = 121
    Height = 37
    Caption = 'Cancelar Pedido'
    TabOrder = 8
    OnClick = btnCancelarPedidoClick
  end
  object dsItensPedido: TDataSource
    DataSet = dmWKTeste.tblItensPedido
    Left = 32
    Top = 272
  end
end
