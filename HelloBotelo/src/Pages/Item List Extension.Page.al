pageextension 50104 "Item List Ext" extends "Item List"
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