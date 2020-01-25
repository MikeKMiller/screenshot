unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Image1: TImage;
    cl: TIdTCPClient;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// Screenshot
procedure ScreenToStream(DrawCur: Boolean; TargetMemoryStream: TMemoryStream);
var
  Mybmp           : TBitmap;
  Cursorx, Cursory: Integer;
  dc              : hdc;
  Mycan           : Tcanvas;
  R               : TRect;
  DrawPos         : TPoint;
  MyCursor        : TIcon;
  hld             : hwnd;
  Threadld        : dword;
  mp              : TPoint;
  pIconInfo       : TIconInfo;
begin
  Mybmp := TBitmap.Create;
  Mycan := Tcanvas.Create;

  dc := GetWindowDC(0);
  try
    Mycan.Handle := dc;
    R            := Rect(0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
    Mybmp.Width  := R.Right;
    Mybmp.Height := R.Bottom;
    Mybmp.Canvas.CopyRect(R, Mycan, R);
  finally
    releaseDC(0, dc);
  end;
  Mycan.Handle := 0;
  Mycan.Free;

  if DrawCur then
  begin
    GetCursorPos(DrawPos);
    MyCursor := TIcon.Create;
    GetCursorPos(mp);
    hld      := WindowFromPoint(mp);
    Threadld := GetWindowThreadProcessId(hld, nil);
    AttachThreadInput(GetCurrentThreadId, Threadld, True);
    MyCursor.Handle := Getcursor();
    AttachThreadInput(GetCurrentThreadId, Threadld, False);
    GetIconInfo(MyCursor.Handle, pIconInfo);
    Cursorx := DrawPos.x - round(pIconInfo.xHotspot);
    Cursory := DrawPos.y - round(pIconInfo.yHotspot);
    Mybmp.Canvas.Draw(Cursorx, Cursory, MyCursor);
    DeleteObject(pIconInfo.hbmColor);
    DeleteObject(pIconInfo.hbmMask);
    MyCursor.ReleaseHandle;
    MyCursor.Free;
  end;
  Mybmp.PixelFormat := pf8bit;
  // ResizeBMP(Mybmp, Width, Height);
  TargetMemoryStream.Clear;
  Mybmp.SaveToStream(TargetMemoryStream);
  Mybmp.Free;
end;

procedure sendToServer(cl: TIdTcpCLient; M: TMemoryStream);
Begin
  cl.Host:= '127.0.0.1';
  cl.Port:= 1453;
  cl.Connect;

  if cl.Connected then
  Begin
    M.Seek(0, soBeginning);

    cl.IOHandler.WriteLn('GETSCREEN');
    cl.IOHandler.WriteBufferClear;
    cl.IOHandler.Write(M.Size);
    cl.IOHandler.Write(M);
  End;

  cl.Disconnect;
End;

procedure TForm1.Button1Click(Sender: TObject);
Var
  M: TMemoryStream;
  B: TBitmap;
begin
  M:= TMemorySTream.Create;

  ScreenToStream(True, M);
  M.Seek(0, sobeginning);

  B:= TBitmap.Create;
  B.LoadFromStream(M);

  Image1.Picture.Assign(B);

  SendToServer(cl, M);

  FreeAndNil(B);
  FreeAndNil(M);
end;

end.
