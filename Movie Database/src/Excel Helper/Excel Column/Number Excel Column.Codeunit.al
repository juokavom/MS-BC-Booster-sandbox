codeunit 50128 "Number Excel Col" implements "Excel Column"
{
    procedure CreateExcelColumn(VariantValue: Variant; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.AddColumn(VariantValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;
}