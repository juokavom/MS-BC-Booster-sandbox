codeunit 50134 "Save To Stream Excel Save" implements "Excel Save"
{
    procedure Save(FileName: Text; var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        TempBlob: Codeunit "Temp Blob";
        ExcelOutStream: OutStream;
        ExcelDocumentExport: Interface "Excel Document Export";
    begin
        TempBlob.CreateOutStream(ExcelOutStream);
        TempExcelBuffer.SaveToStream(ExcelOutStream, true);

        ExcelDocumentExport.Export(FileName, TempBlob);
    end;
}