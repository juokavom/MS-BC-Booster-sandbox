table 50120 Chicken
{
    DataClassification = CustomerContent;
    Caption = 'Chicken';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Chicken Type Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Chicken Type Code';
            TableRelation = "Chicken Type".Code;

            trigger OnValidate()
            begin
                CalcFields("Chicken Type Description")
            end;
        }
        field(6; "Chicken Type Description"; Text[100])
        {
            Caption = 'Chicken Type Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Chicken Type".Description where(Code = field("Chicken Type Code")));
            Editable = false;
        }
        field(4; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(5; Picture; MediaSet)
        {
            DataClassification = CustomerContent;
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