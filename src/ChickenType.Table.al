table 50121 ChickenType
{
    DataClassification = ToBeClassified;
    Caption = 'Chicken Type';

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
            Caption = 'Description';
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