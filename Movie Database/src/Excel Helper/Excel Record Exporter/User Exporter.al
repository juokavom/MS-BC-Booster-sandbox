codeunit 50125 "User Exporter" implements "Excel Record Exporter"
{
    procedure ExportAllRecordsToExcel()
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExcelHelper: Codeunit "Excel Helper";
    begin
        CreateExcelHeaders(TempExcelBuffer);
        ExportAllUserRecordsToExcel(TempExcelBuffer);
        ExcelHelper.CloseExcelFile('Users', TempExcelBuffer);
    end;

    local procedure ExportAllUserRecordsToExcel(var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        User: Record User;
    begin
        if User.FindSet() then
            repeat
                ExportRecordToExcel(User, TempExcelBuffer);
            until User.Next() = 0;
    end;

    procedure CreateExcelHeaders(var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        ExcelColumn: Interface "Excel Column";
    begin
        ExcelColumn := "Excel Column Type"::Header;
        TempExcelBuffer.NewRow();
        ExcelColumn.CreateExcelColumn('First Name', TempExcelBuffer);
        ExcelColumn.CreateExcelColumn('Last Name', TempExcelBuffer);
        ExcelColumn.CreateExcelColumn('Email', TempExcelBuffer);
    end;

    local procedure ExportRecordToExcel(User: Record User; var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        ExcelColumn: Interface "Excel Column";
    begin
        ExcelColumn := "Excel Column Type"::Text;
        TempExcelBuffer.NewRow();
        ExcelColumn.CreateExcelColumn(User."User Security ID", TempExcelBuffer);
        ExcelColumn.CreateExcelColumn(User."User Name", TempExcelBuffer);
        ExcelColumn.CreateExcelColumn(User."Full Name", TempExcelBuffer);
        ExcelColumn.CreateExcelColumn(User."Contact Email", TempExcelBuffer);
        ExcelColumn.CreateExcelColumn(Format(User."License Type"), TempExcelBuffer);
    end;
}