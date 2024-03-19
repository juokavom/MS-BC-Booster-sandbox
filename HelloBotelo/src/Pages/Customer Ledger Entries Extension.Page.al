pageextension 50100 "Customer Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        addfirst(Factboxes)
        {
            part("Customer Reminders Factbox"; "Customer Reminders Factbox")
            {
                ApplicationArea = All;
            }
        }
    }
}