object SampleCriteria: TSampleCriteria
  Left = 0
  Top = 0
  Caption = 'SampleCriteria'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from customers'
      'where false = true')
    Left = 48
    Top = 24
    object FDQueryid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQueryname: TWideStringField
      FieldName = 'name'
      Origin = 'name'
      Size = 255
    end
    object FDQuerycnpj: TWideStringField
      FieldName = 'cnpj'
      Origin = 'cnpj'
      Size = 14
    end
    object FDQuerysponsor_name: TWideStringField
      FieldName = 'sponsor_name'
      Origin = 'sponsor_name'
      Size = 255
    end
    object FDQuerysponsor_email: TWideStringField
      FieldName = 'sponsor_email'
      Origin = 'sponsor_email'
      Size = 255
    end
    object FDQuerysponsor_phone: TWideStringField
      FieldName = 'sponsor_phone'
      Origin = 'sponsor_phone'
      Size = 16
    end
    object FDQueryobservation: TDataSetField
      FieldName = 'observation'
      Origin = 'observation'
      ReadOnly = True
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=manager_dev'
      'User_Name=manager'
      'Password=@embarcadero@'
      'Server=192.168.99.100'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 24
  end
end
