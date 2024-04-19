page 50100 "Vendor Website Settings"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    Caption = 'Vendor Website Settings';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
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
    }

    actions
    {
        area(Processing)
        {
            group("&Line")
            {
                action(ForgotPassword)
                {
                    ApplicationArea = All;
                    Caption = 'Forgot Password';
                    Image = RemoveFilterLines;
                    Promoted = true;
                    Scope = Repeater;
                    Enabled = WebshopPasswordState = "Vendor Password State"::Available;

                    trigger OnAction()
                    begin
                        VendorPasswordManagement.DeletePassword(Rec."No.");
                    end;
                }
                action(ShowPasswordAction)
                {
                    ApplicationArea = All;
                    Caption = 'Show Password';
                    Image = EncryptionKeys;
                    Promoted = true;
                    Scope = Repeater;
                    Enabled = WebshopPasswordState = "Vendor Password State"::Available;

                    trigger OnAction()
                    begin
                        VendorPasswordManagement.ShowPassword(Rec."No.");
                    end;
                }
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