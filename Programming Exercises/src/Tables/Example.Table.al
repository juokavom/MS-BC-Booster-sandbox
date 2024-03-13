table 55102 Example
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Field One"; Integer)
        {
            Caption = 'Field One';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                InsertLog('OnValidate Field One');
            end;

            trigger OnLookup()
            begin
                InsertLog('OnLookup Field One');
            end;
        }
        field(2; "Field Two"; Integer)
        {
            Caption = 'Field Two';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                InsertLog('OnValidate Field Two');
            end;

            trigger OnLookup()
            begin
                InsertLog('OnLookup Field Two');
            end;
        }
    }

    keys
    {
        key(PK; "Field One")
        {
            Clustered = true;
        }
    }

    local procedure InsertLog(TriggerName: Text[100])
    var
        TriggerLogRec: Record "Trigger Log";
    begin
        TriggerLogRec.InsertLogEntry('Example Table', TriggerName);
    end;

    trigger OnInsert()
    begin
        InsertLog('OnInsert');
    end;

    trigger OnModify()
    begin
        InsertLog('OnModify');
    end;

    trigger OnDelete()
    begin
        InsertLog('OnDelete');
    end;

    trigger OnRename()
    begin
        InsertLog('OnRename');
    end;
}