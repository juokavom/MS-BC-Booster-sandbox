pageextension 50131 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Grade No."; Rec."Grade No.")
            {
                ApplicationArea = All;
                Caption = 'Grade No.';
                ToolTip = 'Specifies the value of the Grade No. field.';
            }
            field("Grade Description"; Rec."Grade Description")
            {
                ApplicationArea = All;
                Caption = 'Grade Description';
                ToolTip = 'Specifies the value of the Grade Description field.';
            }
        }
        addfirst(factboxes)
        {
            part("Grade History Factbox"; "Grade History Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }
}