unit formreticle;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LMessages,
  LCLType, Menus, LazLogger, Windows, Types, formhelp, formsplash, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseEnter(Sender: TObject);
    procedure FormMouseLeave(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
  private
         procedure LMNCHitTest(var Msg: TLMNCHitTest) ; message LM_NCHitTest;

  public
        procedure NextReticule();
        procedure PrevReticule();
  end;
const
  INIFILE = 'xaim.ini';

var
  Form1: TForm1;
  Reticles : array[0..8] of String;
  ReticleIndex : integer;

implementation

{$R *.lfm}

procedure TForm1.NextReticule();
begin
  ReticleIndex := ReticleIndex + 1;
  if (ReticleIndex > Length(Reticles) -1 ) then ReticleIndex := 0;
  DebugLn(Format('New index %d %s', [ReticleIndex, Reticles[ReticleIndex]]));
  Image1.Picture.LoadFromFile(Reticles[ReticleIndex])
end;

procedure TForm1.PrevReticule();
begin
  ReticleIndex := ReticleIndex - 1;
  if (ReticleIndex < 0 ) then ReticleIndex := Length(Reticles) - 1;
  DebugLn(Format('New index %d %s', [ReticleIndex, Reticles[ReticleIndex]]));
  Image1.Picture.LoadFromFile(Reticles[ReticleIndex])
end;





procedure TForm1.FormActivate(Sender: TObject);
begin
  Form1.Height:= 16*2;
  Form1.Width:= Form1.Height;

end;



procedure TForm1.FormCreate(Sender: TObject);
var
  settings : TIniFile;
  inivalue : integer;
begin
   LazLogger.GetDebugLogger.CloseLogFileBetweenWrites:=True;

   DebugLn('FormCreate !');
   Reticles[0] := 'reticle_1.png';
   Reticles[1] := 'reticle_2.png';
   Reticles[2] := 'reticle_3.png';
   Reticles[3] := 'reticle_4.png';
   Reticles[4] := 'reticle_5.png';
   Reticles[5] := 'reticle_6.png';
   Reticles[6] := 'reticle_7.png';
   Reticles[7] := 'reticle_8.png';
   Reticles[8] := 'reticle_9.png';
   // load reticle

   Image1.Picture.LoadFromFile(Reticles[0]);


end;

procedure TForm1.FormHide(Sender: TObject);
var
  settings : TIniFile;
begin
  inherited;
  DebugLn('FormHide');
  // A good place to write position
  settings := TIniFile.Create(INIFILE);
  settings.WriteInteger('Main', 'Top', Form1.Top);
  settings.WriteInteger('Main', 'Left', Form1.Left);
  settings.WriteInteger('Main', 'Reticle', ReticleIndex);
  settings.Free;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  DebugLn('FormKeyUp');
  DebugLn(format('keycode %d', [Key]));
  if (Key = VK_Escape) then
  begin
    DebugLn('ESC');
    Application.Terminate;
  end;
  if (Key = VK_F1) then
  begin
    HelpForm.Show;

  end;
  if (ssShift in Shift) then
  begin
    if (Key = VK_UP) then Form1.Top := Form1.Top - 1;
    if (Key = VK_DOWN) then Form1.Top := Form1.Top + 1;
    if (Key = VK_LEFT) then Form1.Left := Form1.Left - 1;
    if (Key = VK_RIGHT) then Form1.Left := Form1.Left + 1;
  end
  else
  begin
    if (Key = VK_LEFT) then PrevReticule();
    if (Key = VK_RIGHT) then NextReticule();
  end;
end;

procedure TForm1.FormMouseEnter(Sender: TObject);
begin
   inherited;
   DebugLn('FormMouseEnter');
end;

procedure TForm1.FormMouseLeave(Sender: TObject);
begin
  inherited;
   DebugLn('FormMouseLeave');
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  DebugLn(Format('FormMouseWheel, delta %d', [WheelDelta]));
  if (WheelDelta > 0) then
  begin
    NextReticule();
  end
  else
  begin
    PrevReticule();
  end;

;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  settings : TIniFile;
begin
    {make the form transparent - works only with Windows operating systems}
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, clWhite, 255, LWA_COLORKEY);
  DebugLn('FormShow !');
  SplashForm.show;
  // Load settings
   settings := TIniFile.Create(INIFILE);
   if (settings.SectionExists('Main')) then
   begin
     Form1.Position:=poDefault;
     Form1.Top := settings.ReadInteger('Main', 'Top', -1);
     Form1.Left:= settings.ReadInteger('Main', 'Left', -1);
     ReticleIndex := settings.ReadInteger('Main', 'Reticle', 0);
     Image1.Picture.LoadFromFile(Reticles[ReticleIndex]);
   end
   else
   begin
     Form1.Position := poScreenCenter;
   end;
   settings.Free;
end;





procedure TForm1.FormWindowStateChange(Sender: TObject);
begin
  DebugLn('FormWindowStateChange');
end;

procedure TForm1.LMNCHitTest(var Msg: TLMNCHitTest);
begin
   inherited;
   if Msg.Result = htClient then Msg.Result := htCaption;
end;

end.

