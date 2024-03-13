table 55100 "My Dev Customer"
{
    DataClassification = CustomerContent;
    Caption = 'My Dev Customer';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Name"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; "City"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}