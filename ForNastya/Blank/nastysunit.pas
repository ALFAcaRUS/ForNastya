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

var

implementation


function getOutArr(numElem:integer):outArr;
var arr: outArr;
Begin
     SetLength(arr,2);
     SetLength(arr[0],num);
     SetLength(arr[1],num);
     getOutArr:= arr;
end;


// основная функция твоей программы
// пиши сюда код
function doSomething():outArr;
var i:integer;
    arr: outArr;
begin
arr:= getOutArr(6);// задай необходимый размер


// сделай что нибудь

doSomething:= arr;// отправь результат в оболочку
end;

Begin

end.

