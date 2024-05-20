codeunit 50129 "Header Excel Col" implements "Excel Column"
{
    procedure CreateExcelColumn(VariantValue: Variant; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.AddColumn(VariantValue, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::"Text");
    end;
}