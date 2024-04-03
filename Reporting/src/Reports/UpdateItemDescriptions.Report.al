report 50142 UpdateItemDescriptions
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Update Item Descriptions';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterHeading = 'Item Selection';
            RequestFIlterFields = "No.", "Description", "Description 2";

            trigger OnPreDataItem()
            begin
                Clear(Counter);
            end;

            trigger OnAfterGetRecord()
            var
                ItemToUpdate: Record Item;
            begin
                Clear(ItemToUpdate);
                if ItemToUpdate.Get(Item."No.") then begin
                    ItemToUpdate."Description 2" := CopyStr("Description" + ' (' + ItemToUpdate."No." + ')', 1, MaxStrLen(ItemToUpdate."Description 2"));
                    ItemToUpdate.Modify();
                    Counter += 1;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Updated %1 items', Counter);
            end;
        }
    }

    var
        Counter: Integer;
}