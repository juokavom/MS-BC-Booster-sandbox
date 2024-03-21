page 50120 "Close Quote"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::LookupOK then FinishWizard();
    end;

    procedure FinishWizard()
    var
        AreEntriesValid: Boolean;
        ErrMessage: Label 'Entries are not valid!';
        ErrDetails: Label 'Check Quote Status or Reason Code and try again.';
    begin
        AreEntriesValid := ((Rec."Won/Lost Quote Status" = "Won Lost Status"::Lost) or
                            (Rec."Won/Lost Quote Status" = "Won Lost Status"::Won)) and
                            (Rec."Reason Code" <> '');
        if not AreEntriesValid then ShowError(ErrMessage, ErrDetails);
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditableBasedOnQuoteStatus();
    end;

    procedure SetEditableBasedOnQuoteStatus()
    begin
        Editable := Rec."Won/Lost Quote Status" = "Won Lost Status"::Won;
    end;

    procedure ShowError(Message: Text; Details: Text)
    var
        ErrorInfo: ErrorInfo;
    begin
        ErrorInfo.Message(Message);
        ErrorInfo.DetailedMessage(Details);
        Error(ErrorInfo);
    end;

    // ??????????????? 
    // By default, a page displays buttons to insert or delete records.
}