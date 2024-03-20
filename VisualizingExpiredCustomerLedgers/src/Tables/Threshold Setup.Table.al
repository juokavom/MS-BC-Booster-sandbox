table 50115 "Threshold Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Threshold Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Threshold 1 Value"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Threshold 2 Value"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Threshold 1 Style"; Enum "Style Type")
        {
            DataClassification = CustomerContent;
        }
        field(5; "Threshold 2 Style"; Enum "Style Type")
        {
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
}