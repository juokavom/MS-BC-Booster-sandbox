codeunit 50135 "Azure Storage Helper"
{
    procedure SaveAttachmentToAzureStorage(FileName: Text; FileExtension: Text; DocInStream: InStream): Boolean
    var
        ABSBlobClient: Codeunit "ABS Blob Client";
    begin

    end;

    procedure DeleteAttachmentFromAzureStorage(FileName: Text; FileExtension: Text): Boolean
    var
        ABSBlobClient: Codeunit "ABS Blob Client";
    begin
        // ABSBlobClient.DeleteBlob();
    end;

    procedure DownloadAttachmentFromAzureStorage(FileName: Text; FileExtension: Text): Boolean
    var
        ABSBlobClient: Codeunit "ABS Blob Client";
    begin
    end;
}