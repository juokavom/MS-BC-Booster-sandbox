pageextension 50102 "Customer Card Ext" extends "Customer Card"
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