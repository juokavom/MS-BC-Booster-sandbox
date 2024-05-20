codeunit 50131 "Browser Excel Document Export" implements "Excel Document Export"
{
    procedure Export(FileName: Text; var TempBlob: Codeunit "Temp Blob")
    var
        ExcelInStream: InStream;
        ExcelFilterLbl: Label 'Excel Files (*.xlsx)|*.xlsx', Locked = true;
    begin
        TempBlob.CreateInStream(ExcelInStream);

        DownloadFromStream(ExcelInStream, 'Download Excel File', '', ExcelFilterLbl, FileName);
    end;
}