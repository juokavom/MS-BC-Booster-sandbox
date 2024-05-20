#pragma warning disable LC0015, AA0228, AA0215
codeunit 50126 "Excel Helper"
{
    Access = Internal;
    SingleInstance = true;

    procedure CloseExcelFile(Name: Text[250]; var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        FileNameTok: Label 'Business Central Booster %1', Locked = true, Comment = '%1 = Name of the set';
        FileNameWithExtensionTok: Label 'Business Central Booster %1.xlsx', Locked = true;
        FileName: Text;
        ExcelSave: Interface "Excel Save";
    begin
        TempExcelBuffer.CreateNewBook(Name);
        TempExcelBuffer.WriteSheet(Name, CompanyName, UserId());
        TempExcelBuffer.CloseBook();

        FileName := StrSubstNo(FileNameTok, Name);
        ExcelSave.Save(FileName, TempExcelBuffer);
    end;

    procedure GetContentType(FileName: Text): Text
    var
        FileManagement: Codeunit "File Management";
    begin
        exit(FileManagement.GetFileNameMimeType(FileName));
    end;
}

