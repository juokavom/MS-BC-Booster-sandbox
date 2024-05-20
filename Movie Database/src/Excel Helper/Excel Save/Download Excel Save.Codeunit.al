codeunit 50133 "Download Excel Save" implements "Excel Save"
{
    procedure Save(FileName: Text; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.SetFriendlyFilename(FileName);
        TempExcelBuffer.OpenExcel();
    end;
}