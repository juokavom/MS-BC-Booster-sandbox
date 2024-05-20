table 50122 "Azure Storage Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Storage Account Name"; Text[50])
        {
            Caption = 'Storage Account Name';
            DataClassification = CustomerContent;
        }
        field(3; "Shared Access Key ID"; Guid)
        {
            Caption = 'Shared Access Key ID';
            DataClassification = CustomerContent;
        }
        field(4; "Container Name"; Text[50])
        {
            Caption = 'Container Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}