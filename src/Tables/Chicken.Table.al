table 50120 Chicken
{
    DataClassification = ToBeClassified;
    Caption = 'Chicken';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; "Chicken Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Chicken Type Code';
            TableRelation = "Chicken Type".Code;
        }
        field(4; "Last Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(5; Picture; MediaSet)
        {
            DataClassification = ToBeClassified;
            Caption = 'Picture';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Chicken Type Code")
        {
        }
        fieldgroup(Brick; Description, Picture)
        {
        }
    }
}