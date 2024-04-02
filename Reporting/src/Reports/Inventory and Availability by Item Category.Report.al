report 50141 "Inv and Avail by Itm Cat"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory and Availability, by Item Category';
    RDLCLayout = './src/Reports/Inventory_And_Availability_By_Item_Category.rdl';

    dataset
    {
        dataitem(Item_Category; "Item Category")
        {
            PrintOnlyIfDetail = true;
            column(Item_Category_Code; "Code")
            {
                IncludeCaption = true;
            }
            column(Item_Category_Description; Description)
            {
                IncludeCaption = true;
            }

            dataitem(Item; Item)
            {
                CalcFields = Inventory, "Qty. on Purch. Order", "Qty. on Sales Order";
                DataItemLink = "Item Category Code" = field("Code");

                column(Item_No; "No.")
                {
                    IncludeCaption = true;
                }
                column(Item_Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Inventory; Inventory)
                {
                    IncludeCaption = true;
                }
                column(Availability; Inventory - "Qty. on Sales Order" + "Qty. on Purch. Order")
                {

                }
            }
        }
    }

    labels
    {
        ReportLbl = 'Inventory and Availability, by Item Category';
        AvailabilityLbl = 'Availability';
    }
}