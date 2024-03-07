page 50129 "Egg Production Line List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Egg Production Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Chicken No."; Rec."Chicken No.")
                {
                    ToolTip = 'Specifies the value of the Chicken number field.';
                }
                field("Chicken Description"; Rec."Chicken Description")
                {
                    ToolTip = 'Specifies the value of the Chicken description field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document Number field.';
                }
                field("Egg Production Date"; Rec."Egg Production Date")
                {
                    ToolTip = 'Specifies the value of the Egg production date field.';
                }
                field("Egg Type Code"; Rec."Egg Type Code")
                {
                    ToolTip = 'Specifies the value of the Egg type code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}