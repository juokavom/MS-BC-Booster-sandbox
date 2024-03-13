pageextension 55100 "Item List Extension" extends "Item List"
{
    layout
    {
        addafter(InventoryField)
        {
            field(Availability; Availability)
            {
                ApplicationArea = All;
                Caption = 'Availability';
                StyleExpr = StyleVar;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Rec."Qty. on Purch. Order", "Qty. on Sales Order");
        Availability := Rec.Inventory + Rec."Qty. on Purch. Order" - Rec."Qty. on Sales Order";
        if Availability = Rec.Inventory then
            StyleVar := 'Standard'
        else
            if Availability < Rec.Inventory then
                StyleVar := 'Attention'
            else
                StyleVar := 'Favorable';
    end;

    var
        Availability: Integer;
        StyleVar: Text;
}