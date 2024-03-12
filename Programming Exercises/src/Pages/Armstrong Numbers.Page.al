page 55103 "Find Armstrong Numbers"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Find Armstrong Numbers';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Enter a start and end number:';
                field(StartNumber; StartNumber)
                {
                    ApplicationArea = All;
                    Caption = 'Start Number';
                }
                field(EndNumber; EndNumber)
                {
                    ApplicationArea = All;
                    Caption = 'End Number';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Armstrong Numbers")
            {
                ApplicationArea = All;
                Caption = 'Get Armstrong Numbers';
                Image = Action;

                trigger OnAction()
                var
                    ArmstrongNumbersCodeunit: Codeunit "Armstrong Numbers";
                begin
                    ArmstrongNumbersCodeunit.PerformCalculations(StartNumber, EndNumber);
                end;
            }
        }
    }

    var
        StartNumber, EndNumber : Integer;
}