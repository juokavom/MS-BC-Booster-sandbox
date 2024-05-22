pageextension 50120 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action(ExportAllAsJSON)
            {
                ApplicationArea = All;
                Caption = 'Export All as JSON';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Export Customers As Json";
            }
        }
    }
}