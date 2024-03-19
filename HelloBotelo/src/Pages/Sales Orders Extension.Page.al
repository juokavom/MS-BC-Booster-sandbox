pageextension 50103 "Sales Orders Ext" extends "Sales Order"
{
    layout
    {
        addafter(SalesLines)
        {
            part("Sales Prices Factbox"; "Sales Prices Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
}