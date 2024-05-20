interface "Excel Record Exporter"
{
    procedure ExportAllRecordsToExcel();

    procedure CreateExcelHeaders(var TempExcelBuffer: Record "Excel Buffer" temporary);
}