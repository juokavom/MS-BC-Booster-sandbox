page 55108 "Example List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Example;
    Caption = 'Example List';
    CardPageId = "Example Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Field One"; Rec."Field One")
                {
                    ToolTip = 'Specifies the value of the Field One field.';
                }
                field("Field Two"; Rec."Field Two")
                {
                    ToolTip = 'Specifies the value of the Field Two field.';
                }
            }
        }
    }
}