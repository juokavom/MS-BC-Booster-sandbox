codeunit 55100 "Variables And Datatypes"
{
    trigger OnRun()
    begin
        Message('The value of %1 is %2', 'LoopNo', LoopNo);
    end;

    var
        Color: Option Red,Green,Blue;
        LoopNo: Integer;
        MyDate: Date;
        MyText: Text;
        LoopNoDec: Decimal;
}