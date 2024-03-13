page 55105 "My Dev Customer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "My Dev Customer";
    Caption = 'My Dev Customer List';
    CardPageId = "My Dev Customer Card";

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(CityFilter; CityFilter)
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Search by City';
                    ToolTip = 'Search by City';
                    trigger OnValidate()
                    begin
                        if not CityFilter.Contains('*')
                        then
                            Error('City search filter must include *');
                    end;
                }
            }
            repeater(Customers)
            {
                Caption = 'Customers';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CopyFromCustomer)
            {
                Caption = 'Copy From Customer';
                ApplicationArea = All;
                Image = Copy;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    DevCustomer: Record "My Dev Customer";
                begin
                    Customer.SetFilter(City, CityFilter);

                    if Customer.FindSet() then begin
                        repeat
                            Clear(DevCustomer);
                            // DevCustomer.TransferFields(Customer); - Copies name into city
                            DevCustomer."No." := Customer."No.";
                            DevCustomer.Name := Customer.Name;
                            DevCustomer.City := Customer.City;
                            DevCustomer.Insert();
                        until Customer.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
            action(DeleteAllRecords)
            {
                Caption = 'Delete All Records';
                ApplicationArea = All;
                Image = "Invoicing-MDL-Delete";

                trigger OnAction()
                var
                    DevCustomer: Record "My Dev Customer";
                begin
                    if DevCustomer.FindSet() then begin
                        DevCustomer.DeleteAll();
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }

    var
        CityFilter: Text;
}