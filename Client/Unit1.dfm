object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 625
  ClientWidth = 1269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 1269
    Height = 584
    Align = alClient
    Stretch = True
    ExplicitTop = -2
  end
  object Panel1: TPanel
    Left = 0
    Top = 584
    Width = 1269
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 1032
      Top = 4
      Width = 233
      Height = 33
      Align = alRight
      Caption = 'G'#246'nder'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object cl: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 64
    Top = 56
  end
end
