table 50123 "Egg Type"
{
    DataClassification = CustomerContent;
    Caption = 'Egg Type';
    LookupPageId = "Egg Types";
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}