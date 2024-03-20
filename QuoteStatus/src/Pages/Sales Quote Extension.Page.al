pageextension 50120 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("Won/Lost Quote Status"; Rec."Won/Lost Quote Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Quote Status field.';
                Editable = false;
            }
            field("Won/Lost Date"; Rec."Won/Lost Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Date field.';
                Editable = false;
            }
            field("Won/Lost Reason Code"; Rec."Won/Lost Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Reason Code field.';
                Editable = false;
            }
            field("Won/Lost Reason Desc"; Rec."Won/Lost Reason Desc")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Reason Desc field.';
                Editable = false;
            }
            field("Won/Lost Remarks"; Rec."Won/Lost Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Won/Lost Remarks field.';
                Editable = false;
            }
        }
    }
}