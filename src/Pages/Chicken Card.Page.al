page 50120 "Chicken Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Chicken;
    Caption = 'Chicken';
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
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
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.';
                }
            }
        }
    }
}