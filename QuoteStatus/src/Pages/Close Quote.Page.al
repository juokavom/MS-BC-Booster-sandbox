page 50120 "Close Quote"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Sales Header";
    Caption = 'Close Quote';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Won/Lost Quote Status"; Rec."Won/Lost Quote Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Won/Lost Quote Status field.';
                    Editable = AllowChangeStatus;
                }
                field("Won/Lost Date"; Rec."Won/Lost Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Won/Lost Date field.';
                }
                field("Won/Lost Reason Code"; Rec."Won/Lost Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Won/Lost Reason Code field.';
                    Editable = AllowChangeStatus;
                }
                field("Won/Lost Reason Desc"; Rec."Won/Lost Reason Desc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Won/Lost Reason Desc field.';
                }
                field("Won/Lost Remarks"; Rec."Won/Lost Remarks")
                {
                    Caption = 'Remarks';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Won/Lost Remarks field.';
                    Editable = AllowChangeStatus;
                    MultiLine = true;
                }
            }
        }
    }

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

    trigger OnOpenPage()
    begin
        SetEditableBasedOnQuoteStatus();
    end;

    var
        AllowChangeStatus: Boolean;

    procedure SetEditableBasedOnQuoteStatus()
    begin
        AllowChangeStatus := Rec."Won/Lost Quote Status" <> "Won Lost Status"::Won;
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