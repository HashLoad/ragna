object FrmRagnaSamples: TFrmRagnaSamples
  Left = 0
  Top = 0
  Caption = 'Ragna samples'
  ClientHeight = 442
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 208
    Width = 658
    Height = 234
    Align = alBottom
    DataSource = dsCountry
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 24
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Open empty'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Or'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 105
    Top = 78
    Width = 75
    Height = 25
    Caption = 'And'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 186
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Like'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 267
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Order'
    TabOrder = 6
    OnClick = Button6Click
  end
  object mmJson: TMemo
    Left = 0
    Top = 119
    Width = 658
    Height = 89
    Align = alBottom
    TabOrder = 7
    ExplicitLeft = 465
    ExplicitTop = 8
    ExplicitWidth = 185
  end
  object Button7: TButton
    Left = 105
    Top = 47
    Width = 75
    Height = 25
    Caption = 'JSON Object'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 186
    Top = 47
    Width = 75
    Height = 25
    Caption = 'JSON Array'
    TabOrder = 9
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 267
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Append'
    TabOrder = 10
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 348
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 11
    OnClick = Button10Click
  end
  object dsCountry: TDataSource
    DataSet = Country
    Left = 304
    Top = 240
  end
  object Country: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from country')
    Left = 344
    Top = 240
    object CountryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 24
    end
    object CountryCapital: TWideStringField
      FieldName = 'Capital'
      Origin = 'Capital'
      Size = 24
    end
    object CountryContinent: TWideStringField
      FieldName = 'Continent'
      Origin = 'Continent'
      Size = 24
    end
    object CountryArea: TFloatField
      FieldName = 'Area'
      Origin = 'Area'
    end
    object CountryPopulation: TFloatField
      FieldName = 'Population'
      Origin = 'Population'
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=DBDEMOS')
    Connected = True
    LoginPrompt = False
    Left = 384
    Top = 240
  end
end
