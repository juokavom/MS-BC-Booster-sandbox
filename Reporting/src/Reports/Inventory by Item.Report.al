report 50140 "Inventory by Item"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory By Item';
    RDLCLayout = './src/Reports/Inventory_By_Item.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(Item_No; "No.")
            {

            }
            column(Item_Description; "Description")
            {

            }
            column(Item_Inventory; "Inventory")
            {

            }
        }
    }
}