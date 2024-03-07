table 50127 "Egg Production Line"
{
    DataClassification = CustomerContent;
    Caption = 'Production Line';
    DrillDownPageId = "Egg Production Line List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Number';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line number';
        }
        field(3; "Chicken No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Chicken number';
            TableRelation = Chicken."No.";
        }
        field(4; "Chicken Description"; Text[100])
        {
            FieldClass = FlowField;
            Caption = 'Chicken description';
            Editable = false;
            CalcFormula = lookup(Chicken.Description where("No." = field("Chicken No.")));
        }
        field(5; "Egg Production Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Egg production date';
        }
        field(6; "Egg Type Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Egg type code';
            TableRelation = EggType;
        }
        field(7; "Egg Type Description"; Text[100])
        {
            Caption = 'Egg type description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(EggType.Description where(Code = field("Egg Type Code")));
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 2 : 0;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}