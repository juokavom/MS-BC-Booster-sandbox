interface "Excel Save"
{
    procedure Save(FileName: Text; var TempExcelBuffer: Record "Excel Buffer" temporary);
}