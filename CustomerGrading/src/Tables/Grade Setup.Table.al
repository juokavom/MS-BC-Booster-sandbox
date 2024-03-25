table 50131 "Grade Setup"
{
    DataClassification = SystemMetadata;
    Caption = 'Grade Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        field(2; "Grade Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
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