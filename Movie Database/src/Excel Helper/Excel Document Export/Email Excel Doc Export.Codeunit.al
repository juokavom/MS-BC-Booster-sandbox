codeunit 50130 "Email Excel Document Export" implements "Excel Document Export"
{
    procedure Export(FileName: Text; var TempBlob: Codeunit "Temp Blob")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        ExcelInStream: InStream;
        ContentType: Text;
    begin
        TempBlob.CreateInStream(ExcelInStream);

        ContentType := ExcelHelper.GetContentType(FileName);

        EmailMessage.Create('info@someone.com', 'Business Central Users', 'Attached is the list of users');
        EmailMessage.AddAttachment(CopyStr(FileName, 1, 250), CopyStr(ContentType, 1, 250), ExcelInStream);
        Email.Send(EmailMessage);
    end;

    var
        ExcelHelper: Codeunit "Excel Helper";
}