page 55102 "Get The Numbers"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Get The Numbers';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(InputText; InputText)
                {
                    Caption = 'Input';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get The Numbers")
            {
                Caption = 'Get The Numbers';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    i: Integer;
                    numbers, newString : Text;
                begin
                    numbers := '0123456789';
                    newString := '';
                    for i := 1 to StrLen(InputText) do begin
                        if numbers.Contains(InputText[i]) then
                            newString := newString + InputText[i];
                    end;
                    Message('%1', newString);
                end;
            }
        }
    }

    var
        InputText: Text;
}