unit uGetOwnIPAddress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPClient, IdStack, IdUDPBase, Vcl.ExtCtrls, Vcl.AppEvnts,
  Vcl.ComCtrls, IdIPWatch;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    IdUDPClient1: TIdUDPClient;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    Button1: TButton;
    IdIPWatch1: TIdIPWatch;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdIPWatch1StatusChanged(Sender: TObject);
    procedure IdIPWatch1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
  private
    LocalAddresses: TStringList;
    LocalAddresses_Prev: TStringList;
    function GetLocalAddress: TStringList;
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.GetLocalAddress():TStringList;
var
  LList: TIdStackLocalAddressList;
  LAddr: TIdStackLocalAddress;
  I: Integer;
  LocalAddresses: TStringList;
begin
  LocalAddresses := TStringList.Create;
  LList := TIdStackLocalAddressList.Create;
  try
    GStack.GetLocalAddressList(LList);
    for I := 0 to LList.Count - 1 do
    begin
      LAddr := LList[I];
      // IPv4 アドレスを取得
      if LAddr is TIdStackLocalAddressIPv4 then
      begin
        LocalAddresses.Add('IPv4: ' + TIdStackLocalAddressIPv4(LAddr).IPaddress);
      end;

      // IPv6 アドレスを取得
      if LAddr is TIdStackLocalAddressIPv6 then
      begin
        LocalAddresses.Add('IPv6: ' + TIdStackLocalAddressIPv6(LAddr).IPaddress);
      end;
    end;

  finally
    LList.Free;
  end;

  // 結果をソートして返す。
  LocalAddresses.Sort;
  Result := LocalAddresses;
end;


procedure TForm1.IdIPWatch1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
//  Memo1.Lines.Insert(0,AStatusText);
end;

procedure TForm1.IdIPWatch1StatusChanged(Sender: TObject);
begin
//  Memo1.Lines.Insert(0,IdIPWatch1.CurrentIP);
//  Memo1.Lines.Insert(0,IdIPWatch1.LocalIP);
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  // 最小化時はトレイアイコン化する
  Hide();
  WindowState := wsMinimized;

  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
// Button1Click という名前を付けているが、
// これは試験実装時の名残り。
var
  I: Integer;
  LocalAddress: String;
  ComputerName: Array[0..256] of char;
  Size: DWORD;
begin
  Memo1.Lines.Clear;

  // 現在のIPアドレス一覧を取得する。
  LocalAddresses := GetLocalAddress;
  LocalAddresses_Prev := LocalAddresses;

  // コンピュータ名を取得する
  Size := 256;
  GetComputerName(ComputerName, Size);
  Memo1.Lines.Add('ComputerName: ' + ComputerName);

  // Memo1 の内容をクリアして、IPアドレス情報を書き出す。
  for i := 0  to LocalAddresses.Count - 1 do
  begin
    Memo1.Lines.Add(LocalAddresses[i]);
    LocalAddress  := LocalAddresses[i];
  end;

  if ( LocalAddresses.Count = 0 ) then
    Memo1.Lines.Add('no network connection.');
end;

// フォームが表示されるときにIPアドレス情報を必ず更新する。
procedure TForm1.FormCreate(Sender: TObject);
begin
  LocalAddresses_Prev := TStringList.Create;

  LocalAddresses_Prev.Add('dummy');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Button1Click(Sender);
end;

// 一定時間ごとにIPアドレス情報を更新する。
procedure TForm1.Timer1Timer(Sender: TObject);
var
  LocalAddressPrevString, LocalAddressString: String;
  i: Integer;
begin
  LocalAddresses := GetLocalAddress;

  for i := 0 to LocalAddresses.Count - 1  do
  begin
     LocalAddressString := LocalAddressString + LocalAddresses[i];
  end;

  for i := 0 to LocalAddresses_Prev.Count - 1  do
  begin
     LocalAddressPrevString := LocalAddressPrevString + LocalAddresses_Prev[i];
  end;


  if (LocalAddressPrevString = LocalAddressString) then
    exit;

  TrayIcon1.BalloonTitle := 'ATTENTION';
  TrayIcon1.BalloonHint := 'IP addresses is changed.';
  TrayIcon1.ShowBalloonHint;

  Button1Click(Sender);
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
