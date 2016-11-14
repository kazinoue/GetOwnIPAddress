object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 186
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 224
    Height = 186
    Align = alClient
    TabOrder = 0
    ExplicitTop = 25
    ExplicitWidth = 178
    ExplicitHeight = 161
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 48
    Top = 56
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 120
    Top = 56
  end
end
