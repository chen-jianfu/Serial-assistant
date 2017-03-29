unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,Registry,Windows;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    ComboBoxDeviceName: TComboBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation
uses Unit1;
{$R *.lfm}
{ TForm2 }
procedure EnumComDevicesFromRegistry(List: TStrings);
var
  Names: TStringList;
  i: Integer;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('\HARDWARE\DEVICEMAP\SERIALCOMM') then
      begin
        Names := TStringList.Create;
        try
          GetValueNames(Names);
          for i := 0 to Names.Count - 1 do
            if GetDataType(Names[i]) = rdString then
              List.Add(ReadString(Names[i]));
        finally
          Names.Free;
        end
      end;
  finally
    Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  with ComboBoxDeviceName do
  begin
    EnumComDevicesFromRegistry(Items);
    ItemIndex := 0;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  with form1.comm1 do
  begin
   CommName:= ComboBoxDeviceName.text;
   StartComm;
   form2.Close;
  end;
end;





end.

