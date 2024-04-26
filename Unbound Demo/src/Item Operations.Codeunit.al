codeunit 50110 "Item Operations"
{
    procedure UpdatePrices(percentage: Decimal) ModifiedItems: Integer
    var
        Item: Record Item;
    begin
        Clear(Item);
        ModifiedItems := 0;

        if Item.FindSet() then
            repeat
                Item."Unit Price" := Item."Unit Price" + Item."Unit Price" * percentage / 100;
                if Item.Modify() then
                    ModifiedItems := ModifiedItems + 1;
            until Item.Next() = 0;

        exit(ModifiedItems);
    end;
}