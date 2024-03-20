tableextension 50121 "Sales Header Archive Ext" extends "Sales Header Archive"
{
    fields
    {
        field(50120; "Won/Lost Quote Status"; Enum "Won Lost Status")
        {
            DataClassification = CustomerContent;
        }
        field(50121; "Won/Lost Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
            // Todo: Assign date on status set
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

    procedure SetWonLostAssignDate()
    begin
        Rec."Won/Lost Date" := System.CurrentDateTime();
    end;
}