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
                    // Customer.FindFirst();
                    Customer.FindLast();
                    Message('%1', Customer);
                end;
            }
            action(LoopOverAllVendors)
            {
                Caption = 'Loop all Vendors';
                ToolTip = 'Loop all Vendors';
                ApplicationArea = All;
                Image = Find;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    Vendor.FindSet();
                    repeat
                        Message('%1', Vendor);
                    until Vendor.Next() = 0;
                end;
            }
        }
    }
}