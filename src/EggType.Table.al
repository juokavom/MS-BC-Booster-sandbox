table 50123 EggType
{
    DataClassification = ToBeClassified;
    Caption = 'Egg Type';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
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