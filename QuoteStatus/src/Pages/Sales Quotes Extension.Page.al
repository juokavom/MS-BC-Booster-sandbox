pageextension 50122 "Sales Quotes Ext" extends "Sales Quotes"
{
    layout
    {
        addafter("Due Date")
        {
            field("Won/Lost Quote Status"; Rec."Won/Lost Quote Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Quote Status field.';
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
            }
            field("Won/Lost Reason Desc"; Rec."Won/Lost Reason Desc")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Reason Desc field.';
            }
            field("Won/Lost Remarks"; Rec."Won/Lost Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Remarks field.';
            }
        }
    }

    actions
    {
        addfirst(Creation)
        {
            action(Action1)
            {
                ApplicationArea = All;
                Caption = 'Action';
                ToolTip = 'Action';
                Image = Close;
                trigger OnAction()
                begin
                    OnActionClick();
                end;
            }
        }

        addfirst(Processing)
        {
            action(Action2)
            {
                ApplicationArea = All;
                Caption = 'Action';
                ToolTip = 'Action';
                Image = Close;

                trigger OnAction()
                begin
                    OnActionClick();
                end;
            }
        }
    }

    procedure OnActionClick()
    var
        CloseQuote: Page "Close Quote";
        CloseQuoteMgmt: Codeunit "Quote Status Mgmt";
    begin
        if CloseQuote.RunModal() = Action::LookupOK then CloseQuoteMgmt.CloseQuote();
    end;
}