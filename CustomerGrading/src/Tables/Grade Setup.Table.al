table 50131 "Grade Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Grade Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Grade Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade Nos.';
            TableRelation = "No. Series";
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