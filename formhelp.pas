unit formhelp;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { THelpForm }

  THelpForm = class(TForm)
    MemoHelp: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure MemoHelpChange(Sender: TObject);
  private

  public

  end;

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

{ THelpForm }

procedure THelpForm.MemoHelpChange(Sender: TObject);
begin

end;

procedure THelpForm.FormCreate(Sender: TObject);
begin

end;

end.

