page 55101 "Price Calculator"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Price Calculator';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                    Caption = 'Price';
                }
            }
            group(Output)
            {
                Caption = 'Output';
                Editable = false;
                field(Result; Result)
                {
                    Caption = 'Result';
                    ApplicationArea = All;
                }
                field(TotalCredits; TotalCredits)
                {
                    Caption = 'Total Credits';
                    ApplicationArea = All;
                }
                field(TotalSales; TotalSales)
                {
                    Caption = 'Total Sales';
                    ApplicationArea = All;
                }
                field(GrandTotal; GrandTotal)
                {
                    Caption = 'Grand Total';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                Caption = 'Execute';
                Image = Calculate;

                trigger OnAction()
                begin
                    if Quantity = 0 then
                        exit
                    else begin
                        Result := Quantity * Price;
                        if Result < 0 then
                            TotalCredits := TotalCredits + 1
                        else
                            TotalSales := TotalSales + 1;
                        GrandTotal := GrandTotal + 1;
                    end;
                end;
            }
            action(Clear)
            {
                ApplicationArea = All;
                Caption = 'Clear';
                Image = ClearFilter;

                trigger OnAction()
                begin
                    Quantity := 0;
                    Price := 0;
                    Result := 0;
                    TotalCredits := 0;
                    TotalSales := 0;
                    GrandTotal := 0;
                end;
            }
        }
    }

    var
        Quantity, Price, Result, TotalCredits, TotalSales, GrandTotal : Decimal;
}