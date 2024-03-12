page 55104 "Data Manipulation Examples"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Data Manipulation Examples';

    layout
    {
        area(Content)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(FindSomeRecords)
            {
                Caption = 'Find Some Records';
                ToolTip = 'Find Some Records';
                ApplicationArea = All;
                Image = Find;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.FindFirst();
                    Message('%1', Customer);
                end;
            }
        }
    }
}