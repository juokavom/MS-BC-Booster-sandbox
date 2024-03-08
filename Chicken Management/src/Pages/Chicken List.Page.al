page 50121 "Chicken List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Chicken;
    Editable = false;
    Caption = 'Chickens';
    CardPageId = "Chicken Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Chicken Type Code"; Rec."Chicken Type Code")
                {
                    ToolTip = 'Specifies the value of the Chicken Type Code field.';
                }
                field("Eggs Produced"; Rec."Eggs Produced")
                {
                    ToolTip = 'Specifies the value of the Eggs Produced field.';
                }
            }
        }
    }
}