table 50123 EggType
{
    DataClassification = CustomerContent;
    Caption = 'Egg Type';

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