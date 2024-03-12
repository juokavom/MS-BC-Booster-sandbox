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
            action(GetItem)
            {
                ApplicationArea = All;
                Caption = 'Get Item';
                ToolTip = 'Get Item';
                Image = GeneralPostingSetup;

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    if Item.Get('1900-S') then
                        Message('%1', Item);
                end;
            }
            action(GetCustomersFromAtlanta)
            {
                ApplicationArea = All;
                Caption = 'Get Customers From Atlanta';
                ToolTip = 'Get Customers From Atlanta';
                Image = SalesPurchaseTeam;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.SetRange(City, 'Atlanta');
                    if Customer.FindSet() then
                        repeat
                            Message('%1', Customer)
                        until Customer.Next() = 0;
                end;
            }
            action(GetCustomersNotFromAtlanta)
            {
                ApplicationArea = All;
                Caption = 'Get Customers Not From Atlanta';
                ToolTip = 'Get Customers Not From Atlanta';
                Image = SalesPurchaseTeam;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.SetFilter(City, '<>Atlanta');
                    if Customer.FindSet() then
                        repeat
                            Message('%1', Customer)
                        until Customer.Next() = 0;
                end;
            }
        }
    }
}