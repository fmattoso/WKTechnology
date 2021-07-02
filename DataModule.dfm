object dmWKTeste: TdmWKTeste
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 615
  Width = 730
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=wkteste'
      'DriverID=MySQL'
      'Password=ffm#7276'
      'User_Name=root'
      'Server=localhost')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\Fabiano\Documents\Teste WK\Win32\Debug\libmysql.dll'
    Left = 240
    Top = 16
  end
  object tblItensPedido: TFDMemTable
    BeforePost = tblItensPedidoBeforePost
    FieldDefs = <
      item
        Name = 'codigoProduto'
        DataType = ftInteger
      end
      item
        Name = 'descricaoProduto'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'quantidade'
        DataType = ftFloat
      end
      item
        Name = 'vlrUnitario'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'vlrTotal'
        DataType = ftCurrency
        Precision = 19
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 32
    Top = 88
    object tblItensPedidocodigoProduto: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'codigoProduto'
      OnChange = tblItensPedidocodigoProdutoChange
    end
    object tblItensPedidodescricaoProduto: TStringField
      DisplayLabel = 'Descricao do Produto'
      FieldName = 'descricaoProduto'
      Size = 100
    end
    object tblItensPedidoquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      DisplayFormat = '#,##0.###'
    end
    object tblItensPedidovlrUnitario: TCurrencyField
      DisplayLabel = 'Vlr. Unit'#225'rio'
      FieldName = 'vlrUnitario'
    end
    object tblItensPedidovlrTotal: TCurrencyField
      DisplayLabel = 'Vlr. Total'
      FieldName = 'vlrTotal'
    end
  end
  object qryAux: TFDQuery
    Connection = FDConnection1
    Left = 128
    Top = 88
  end
  object qryLocProduto: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT descricao FROM produtos'
      'WHERE codigo = :codigo')
    Left = 216
    Top = 88
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
