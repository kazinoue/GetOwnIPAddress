object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'GetOwnIPaddess'
  ClientHeight = 186
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 25
    Width = 304
    Height = 161
    Align = alClient
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 304
    Height = 25
    Align = alTop
    Caption = 'reload IPaddress'
    TabOrder = 1
    OnClick = Button1Click
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 48
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 120
    Top = 56
  end
  object TrayIcon1: TTrayIcon
    OnClick = TrayIcon1DblClick
    OnDblClick = TrayIcon1DblClick
    Left = 240
    Top = 64
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 248
    Top = 120
  end
  object IdIPWatch1: TIdIPWatch
    OnStatus = IdIPWatch1Status
    Active = True
    HistoryFilename = 'iphist.dat'
    OnStatusChanged = IdIPWatch1StatusChanged
    Left = 48
    Top = 128
  end
end
