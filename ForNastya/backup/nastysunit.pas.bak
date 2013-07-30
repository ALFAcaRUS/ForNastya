//==================================
//
//==================================

unit NastysUnit;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

  Type outArr = array of array of real; // тип выходного массива
  function doSomething():outArr; // объявление основной функции. функцию ищи ниже

var phi:real;

implementation


function getOutArr(numElem:integer):outArr;
var arr: outArr;
Begin
     SetLength(arr,2);
     SetLength(arr[0],numElem);
     SetLength(arr[1],numElem);
     getOutArr:= arr;
end;


// основная функция твоей программы
// пиши сюда код
function doSomething():outArr;
var i:integer;
    arr: outArr;
    x:real;
const numPoint = 500;
begin
arr:= getOutArr(numPoint);// задай необходимый размер

for i :=0 to numPoint + 1 do
    begin
      x:= 0.1*i - 25;
      arr[0,i] := x;
      arr[1,i] := -0.1*(x*x) + 50 * phi;
    end;

if phi <= 1 then
   phi:= phi + 0.001
else
   phi:=0.01;
doSomething:= arr;// отправь результат в оболочку
end;

Begin

phi:=0.01;

end.

