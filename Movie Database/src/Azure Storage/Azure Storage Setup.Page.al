page 50126 "Azure Storage Setup Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Azure Storage Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.', Comment = '%';
                }
                field("Storage Account Name"; Rec."Storage Account Name")
                {
                    ToolTip = 'Specifies the value of the Storage Account Name field.', Comment = '%';
                }
                field("Shared Access Key ID"; Rec."Shared Access Key ID")
                {
                    ToolTip = 'Specifies the value of the Shared Access Key ID field.', Comment = '%';
                }
                field("Container Name"; Rec."Container Name")
                {
                    ToolTip = 'Specifies the value of the Container Name field.', Comment = '%';
                }
                field(SharedAccessKey; SharedAccessKey)
                {
                    ToolTip = 'Specifies the value of the Shared Access Key.', Comment = '%';

                    trigger OnValidate()
                    begin
                        SaveSharedAccessKey();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        GetSharedAccessKey();
    end;

    local procedure SaveSharedAccessKey()
    begin
        IsolatedStorage.Set('SharedAccessKey', SharedAccessKey, DataScope::Company);
    end;

    local procedure GetSharedAccessKey()
    begin
        IsolatedStorage.Get('SharedAccessKey', DataScope::Company, SharedAccessKey);
    end;

    var
        [NonDebuggable]
        SharedAccessKey: Text;
}