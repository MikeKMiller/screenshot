unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IdBaseComponent,
  IdComponent, IdCustomTCPServer, IdTCPServer, IdTCPClient, IdContext;

type
  TForm1 = class(TForm)
    Image1: TImage;
    cs: TIdTCPServer;
    procedure csExecute(AContext: TIdContext);
  private
    procedure readImage(AContext: TIdContext);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ReadStream(C: TIdContext; oStream: TStream): Boolean;
Var
  cmd: String;
  oSize, sSize: Int64;
Begin
  Result:= False;

  C.Connection.IOHandler.WriteBufferClear;
  sSize := C.Connection.IOHandler.ReadInt64;
  if sSize > 0 then
  Begin
    C.Connection.IOHandler.ReadStream(oStream, sSize);
    oSize:= oStream.Size;
    Result:= oSize = sSize;
    if Result Then
      oStream.Seek(0, soBeginning);
  End;
End;

procedure TForm1.csExecute(AContext: TIdContext);
Var
  cmd: String;
begin
  cmd := AContext.Connection.Socket.ReadLn;
  if SameText(cmd, 'GETSCREEN') then
    readImage(AContext)
end;

procedure TForm1.readImage(AContext: TIdContext);
Var
  M: TMemoryStream;
  B: TBitmap;
begin
  M:= TMemorySTream.Create;

  if ReadStream(AContext, M) then
  Begin
    M.Seek(0, sobeginning);

    B:= TBitmap.Create;
    B.LoadFromStream(M);

    Image1.Picture.Assign(B);

    FreeAndNil(B);
    FreeAndNil(M);
  End;
end;

end.
