unit TestCase1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, Main, NastysUnit;

type

  TTestCase1= class(TTestCase)
  published
    procedure TestHookUp;
    procedure scalingTest;
  end;

implementation

procedure TTestCase1.TestHookUp;
begin
  Fail('Нихуа!');
end;

procedure TTestCase1.scalingTest;
var arr:outArr;
    i:integer;
const numElem = 789;
begin
     SetLength(arr,2);
     SetLength(arr[0],numElem);
     SetLength(arr[1],numElem);

     for i:=0 to numElem do
         begin
           arr[0,i] := i;
           arr[1,i] := i;
         end;

     //AssertEquals(1,Form1.sc);
end;

initialization

  RegisterTest(TTestCase1);
end.

