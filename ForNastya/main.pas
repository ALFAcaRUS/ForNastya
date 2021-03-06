unit Main;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls, NastysUnit;

type

  { TForm1 }

    TForm1 = class(TForm)
        Timer1: TTimer;
        procedure FormCreate(Sender: TObject);
        procedure Timer1Timer(Sender: TObject);
    private
        scaleX,scaleY:real;
        offsetX, offsetY:real;
        enableGraph: boolean;
    procedure scaling(var inArr: outArr);
    { private declarations }
    public
    { public declarations }
    end;

var
    Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

//////////////////////////// Support metods ////////////////////////////////////

// search minimal and maximal elements of array
function arrMax(arr: array of real): real;
    var i: integer;
        max:real;
begin
    max := arr[0];
    for i:=1 to Length(arr) - 1 do
        if arr[i]>max then max:= arr[i];
    arrMax := max;
end;

function arrMin(arr: array of real): real;
    var i:integer;
        min:real;
begin
    min := arr[0];
    for i:=0 to Length(arr) - 1 do
        if arr[i]<min then
            min:= arr[i];
    arrMin := min;
end;

// calculation offset
function scale(arr: array of real; size:integer):real;
begin
    scale:= size/(arrMax(arr)-arrMin(arr));
end;

procedure testInfo(inArr:outArr; file1:String; file2:String);
    var i:integer;
        test1,test2:text;
begin
    AssignFile(test1, file1);
    AssignFile(test2, file2);
    Rewrite(test1);
    Rewrite(test2);
    for i:=0 to Length(inArr[0]) do
        begin
            write(test1,inArr[0,i]:6:2);
            write(test1,' ');
            write(test2,inArr[1,i]:6:2);
            write(test2,' ');
        end;

    CloseFile(test1);
    CloseFile(test2);
end;

// scaling array with form size
procedure TForm1.scaling(var inArr: outArr);
    var i:integer;
begin
    //testInfo(inArr,'original1.txt','original2.txt');

    // calculation scale
    scaleX:=scale(inArr[0],Form1.Width);
    scaleY:=scale(inArr[1],Form1.Height)*(-1);

    // calculation offset
    offsetX:= -arrMin(inArr[0])*scaleX;
    offsetY:= (-arrMin(inArr[1]))*scaleY + Form1.Height;

    for i:=0 to Length(inArr[0]) do
        begin
            inArr[0,i] := scaleX * inArr[0,i] + offsetX;
            inArr[1,i] := scaleY * inArr[1,i] + offsetY;
        end;

    //testInfo(inArr,'scaled1.txt','scaled2.txt');

end;

//////////////////////////// Graphics metods ///////////////////////////////////

// initialization buffer
function getBufer():TBitmap;
    var buf:TBitmap;
begin

    buf:= TBitmap.Create;

    buf.Height:=Form1.Height;
    buf.Width:=Form1.Width;

    buf.Canvas.Brush.Color:=clWhite;
    buf.Canvas.FillRect(0,0,Form1.Width,Form1.Height);

    getBufer := buf;
end;

procedure drowCoord(var buf:TBitmap);
    var x1,x2,y1,y2:integer;
begin
    x1:= Round(Form1.scaleX + Form1.offsetX);
    x2:= Round(-Form1.scaleX + Form1.offsetX);
    y1:= Round(Form1.scaleY + Form1.offsetY);
    y2:= Round(-Form1.scaleY + Form1.offsetY);
    with buf.Canvas do
        begin
            Brush.Color:=clGreen;
            Pen.Color:=clBlack;
            Pen.Width:=2;
            MoveTo(0,Round(Form1.offsetY));
            LineTo(Form1.Width,Round(Form1.offsetY));
            MoveTo(Round(Form1.offsetX),0);
            LineTo(Round(Form1.offsetX),Form1.Height);
            Pen.Color:=clGreen;
            Ellipse(x1+2, Round(Form1.offsetY) + 2,x1-2, Round(Form1.offsetY) - 2);
            Ellipse(x2+2, Round(Form1.offsetY) + 2,x2-2, Round(Form1.offsetY) - 2);
            Ellipse(Round(Form1.offsetX) + 2, y1+2,Round(Form1.offsetX) - 2, y1-2);
            Ellipse(Round(Form1.offsetX) + 2, y2+2,Round(Form1.offsetX) - 2, y2-2);

        end;
end;

// drow gpaphic
procedure drowLines(inArr:outArr; var buf:TBitmap);
    var i:integer;
begin

    with buf.Canvas do
        begin
            Pen.Color:=clRed;
            Pen.Width:=1;
            MoveTo(Round(inArr[0,0]), Round(inArr[1,0]));
            for i:= 1 to Length(inArr[0]) do
                LineTo(Round(inArr[0,i]), Round(inArr[1,i]));
        end;


end;

// do not connect the dots
procedure drowPoints(inArr:outArr; var buf:TBitmap);
    var i:integer;
begin

    with buf.Canvas do
        begin
            Brush.Color:=clBlack;
            for i:= 0 to Length(inArr[0]) do
                Ellipse(Round(inArr[0,i]+2), Round(inArr[1,i]+2),Round(inArr[0,i]-2), Round(inArr[1,i]-2));
        end;


end;

// drowing graphic
procedure drowGrap(arr: outArr);
    var i:integer;
        buf:TBitmap;
begin

    buf:=getBufer();

    Form1.scaling(arr);

    if Form1.enableGraph = True then
        begin
            drowCoord(buf);
            drowLines(arr,buf);
        end
    else
        drowPoints(arr,buf);

    Form1.Canvas.Draw(0,0,buf);

    buf.Destroy;

end;

//////////////////////////// Event handlers ////////////////////////////////////

procedure TForm1.FormCreate(Sender: TObject);
    var i:integer;
        arr:outArr;
        summ:real;
        config:Text;
        confVar:String;
begin

    AssignFile(config,'MainConfig.ini');
    Reset(config);

    try
        begin
            ReadLn(config,confVar);
            If  confVar = 'True' Then
                Timer1.Enabled:=True
            else
                Timer1.Enabled:=False;

            ReadLn(config,confVar);
            If confVar = 'True' Then
                Form1.enableGraph:=True
            else
                Form1.enableGraph:=False;

        end;
    finally
        CloseFile(config);
    end;

    drowGrap(doSomething());

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

    drowGrap(doSomething());

end;

end.

