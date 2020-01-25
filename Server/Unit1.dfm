object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 549
  ClientWidth = 1259
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
    Width = 1259
    Height = 549
    Align = alClient
    Stretch = True
    ExplicitLeft = -10
    ExplicitTop = -35
    ExplicitWidth = 1269
    ExplicitHeight = 584
  end
  object cs: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 1453
    OnExecute = csExecute
    Left = 104
    Top = 80
  end
end
