codeunit 50127 "Text Excel Col" implements "Excel Column"
{
    procedure CreateExcelColumn(VariantValue: Variant; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.AddColumn(VariantValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::"Text");
    end;
}