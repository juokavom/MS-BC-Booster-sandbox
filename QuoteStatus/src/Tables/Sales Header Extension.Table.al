tableextension 50120 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50120; "Won/Lost Quote Status"; Enum "Won Lost Status")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetWonLostAssignDateIfEmpty();
            end;
        }
        field(50121; "Won/Lost Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50122; "Won/Lost Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation =
                if ("Won/Lost Quote Status" = const("Won Lost Status"::Won))
                        "Close Opportunity Code" where(Type = filter(Won))
            else if ("Won/Lost Quote Status" = const("Won Lost Status"::Lost))
                        "Close Opportunity Code" where(Type = filter(Lost));

        }
        field(50123; "Won/Lost Reason Desc"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Close Opportunity Code".Description
                            where("Code" = field("Won/Lost Reason Code")));
        }
        field(50124; "Won/Lost Remarks"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
    }

    procedure SetWonLostAssignDateIfEmpty()
    begin
        if "Won/Lost Date" = 0DT then "Won/Lost Date" := CurrentDateTime();
    end;
}