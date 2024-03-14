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
        field(7; "Eggs Produced"; Decimal)
        {
            Caption = 'Eggs Produced';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Egg Production Line".Quantity where("Chicken No." = field("No."),
                                                                    "Egg Production Date" = field("Date Filter"),
                                                                    "Egg Type Code" = field("Egg Type Filter")
                                                                ));
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Egg Type Filter"; Code[20])
        {
            Caption = 'Egg Type';
            FieldClass = FlowFilter;
            TableRelation = "EggType";
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

    trigger OnDelete()
    var
        EggProductionLine: Record "Egg Production Line";
        ChickenHasEggsErr: Label 'The Chicken %1 %2 has eggs, you can''t detele it.',
                           Comment = '%1 = Chicken No. ; %2 = Chicken Description';
    begin
        Clear(EggProductionLine);
        EggProductionLine.SetFilter("Chicken No.", Rec."No.");
        if EggProductionLine.FindFirst() then Error(ChickenHasEggsErr);
    end;
}