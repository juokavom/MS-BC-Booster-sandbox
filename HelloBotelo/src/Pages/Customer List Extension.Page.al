pageextension 50101 "Customer List Ext" extends "Customer List"
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