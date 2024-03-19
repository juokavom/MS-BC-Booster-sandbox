pageextension 50105 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addfirst(Factboxes)
        {
            part("Sales Prices Factbox"; "Sales Prices Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
}