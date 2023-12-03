unit formsplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TSplashForm }

  TSplashForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.lfm}

{ TSplashForm }

procedure TSplashForm.FormCreate(Sender: TObject);
begin

end;

procedure TSplashForm.Label1Click(Sender: TObject);
begin

end;

procedure TSplashForm.Label2Click(Sender: TObject);
begin

end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  SplashForm.Close;
end;

end.

