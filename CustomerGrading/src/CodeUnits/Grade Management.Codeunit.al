codeunit 50130 "Grade Management"
{
    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm,
                  TableData "Cust. Ledger Entry" = rm;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Grade No.', false, false)]
    local procedure AssignGradeToCustomer(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        GradeHistory: Record "Grade History";
    begin
        GradeHistory.InsertIntoGradeHistory(
            Rec."No.",
            Today(),
            'Customer',
            Rec."No.",
            Rec."Grade No."
        )
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure AssignGradeToSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        GradeHistory: Record "Grade History";
        Customer: Record Customer;
    begin
        if Rec."Bill-to Customer No." = '' then exit;

        Clear(Customer);
        if not Customer.Get(Rec."Bill-to Customer No.") then exit;
        if Customer."Grade No." = '' then exit;

        Rec."Grade No." := Customer."Grade No.";

        GradeHistory.InsertIntoGradeHistory(
            Rec."Bill-to Customer No.",
            Rec."Posting Date",
            'Sales ' + Format(Rec."Document Type"),
            Format(Rec."No."),
            Rec."Grade No."
        )
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure AssignGradeToCustomerLedger(var Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    var
        GradeHistory: Record "Grade History";
        Customer: Record Customer;
    begin
        if Rec."Document No." = '' then exit;

        Clear(Customer);
        if not Customer.Get(Rec."Customer No.") then exit;
        if Customer."Grade No." = '' then exit;

        Rec."Grade No." := Customer."Grade No.";
        if Rec.Modify() then begin
            GradeHistory.InsertIntoGradeHistory(
                    Rec."Customer No.",
                    Rec."Document Date",
                    'Customer Ledger Entry',
                    Format(Rec."Entry No."),
                    Rec."Grade No."
                )
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure AssignGradeDuringSalesPost(
            var SalesHeader: Record "Sales Header";
            var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
            SalesShptHdrNo: Code[20];
            RetRcpHdrNo: Code[20];
            SalesInvHdrNo: Code[20];
            SalesCrMemoHdrNo: Code[20];
            CommitIsSuppressed: Boolean;
            InvtPickPutaway: Boolean;
            var CustLedgerEntry: Record "Cust. Ledger Entry";
            WhseShip: Boolean;
            WhseReceiv: Boolean;
            PreviewMode: Boolean
        )
    var
        GradeHistory: Record "Grade History";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        if SalesHeader."Bill-to Customer No." = '' then exit;

        Clear(Customer);
        if not Customer.Get(SalesHeader."Bill-to Customer No.") then exit;
        if Customer."Grade No." = '' then exit;

        if SalesInvHdrNo <> '' then begin
            Clear(SalesInvoiceHeader);
            SalesInvoiceHeader.Get(SalesInvHdrNo);
            SalesInvoiceHeader."Grade No." := Customer."Grade No.";
            SalesInvoiceHeader.Modify();

            GradeHistory.InsertIntoGradeHistory(
                SalesInvoiceHeader."Bill-to Customer No.",
                SalesInvoiceHeader."Posting Date",
                'Posted Sales Invoice',
                SalesInvoiceHeader."No.",
                SalesInvoiceHeader."Grade No."
            )
        end;

        if SalesCrMemoHdrNo <> '' then begin
            Clear(SalesCrMemoHeader);
            SalesCrMemoHeader.Get(SalesCrMemoHdrNo);
            SalesCrMemoHeader."Grade No." := Customer."Grade No.";
            SalesCrMemoHeader.Modify();

            GradeHistory.InsertIntoGradeHistory(
                SalesCrMemoHeader."Bill-to Customer No.",
                SalesCrMemoHeader."Posting Date",
                'Posted Sales Cr. Memo',
                SalesCrMemoHeader."No.",
                SalesCrMemoHeader."Grade No."
            )
        end;
    end;
}