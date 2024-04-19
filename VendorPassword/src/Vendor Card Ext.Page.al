pageextension 50100 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("Webshop Password"; WebshopPasswordState)
            {
                ApplicationArea = All;
                Caption = 'Webshop Password';
                Editable = false;

                trigger OnDrillDown()
                begin
                    VendorPasswordManagement.HandlePaswordAction(Rec."No.", WebshopPasswordState);
                end;
            }
        }
    }

    var
        WebshopPasswordState: Enum "Vendor Password State";
        VendorPasswordManagement: Codeunit "Vendor Password Management";

    trigger OnAfterGetRecord()
    begin
        WebshopPasswordState := VendorPasswordManagement.GetPasswordState(Rec."No.");
    end;
}
