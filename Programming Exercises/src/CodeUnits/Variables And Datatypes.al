codeunit 55100 "Variables And Datatypes"
{

    var
        Color: Option Red,Green,Blue;
        LoopNo: Integer;
        MyDate: Date;
        MyText: Text;
        LoopNoDec: Decimal;
        String1: Text[60];
        String2: Text[30];

    trigger OnRun()
    begin
        String1 := 'HelloWorldOfManyManyCharactersInTheString';
        String2 := CopyStr(String1, 1, MaxStrLen(String2));
        Message('The value of %1 is %2. The %1 lenght is %3', 'String2', String2, MaxStrLen(String2));
    end;

}