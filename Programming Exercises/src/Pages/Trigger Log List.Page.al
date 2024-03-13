page 55107 "Trigger Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Trigger Log";
    Caption = 'Trigger Log List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.';
                }
                field("Trigger Name"; Rec."Trigger Name")
                {
                    ToolTip = 'Specifies the value of the Trigger Name field.';
                }
                field(Timestamp; Rec.Timestamp)
                {
                    ToolTip = 'Specifies the value of the Timestamp field.';
                }
            }
        }
    }
}