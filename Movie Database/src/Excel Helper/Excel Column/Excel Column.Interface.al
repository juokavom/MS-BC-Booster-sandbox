interface "Excel Column"
{
    procedure CreateExcelColumn(VariantValue: Variant; var TempExcelBuffer: Record "Excel Buffer" temporary);
}