codeunit 50121 "Quote Status Mgmt"
{
    procedure CloseQuote()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesHeader: Record "Sales Header";
    begin
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);
    end;
}