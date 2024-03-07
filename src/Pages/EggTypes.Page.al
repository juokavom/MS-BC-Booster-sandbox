page 50123 "Egg Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = EggType;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Caption field.';
                }
            }
        }
    }
}