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

  private

  public

  end;

var
  HelpForm: THelpForm;

implementation

{$R *.lfm}

{ THelpForm }



procedure THelpForm.FormCreate(Sender: TObject);
begin

end;

end.

