page 50123 "Egg Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EggType";

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

    actions
    {
        area(Creation)
        {
            action(InsertDefaultEggTypes)
            {
                ApplicationArea = All;
                Image = Allocations;
                Caption = 'Insert Default Egg Types';
                ToolTip = 'Insert Default Egg Types';

                trigger OnAction()
                var
                    EggType: Record EggType;
                    EggTypeNotEmptyErr: Label 'There are already Egg Types in the table';
                begin
                    Clear(EggType);
                    if EggType.IsEmpty then begin
                        EggType.InsertEggType('WHITE', 'White Egg');
                        EggType.InsertEggType('BROWN', 'Brown Egg');
                        EggType.InsertEggType('BROKEN', 'Broken Egg');
                    end else
                        Error(EggTypeNotEmptyErr);
                end;
            }
        }
    }
}