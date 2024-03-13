table 55101 "Trigger Log"
{
    DataClassification = CustomerContent;
    Caption = 'Trigger Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Object Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Object Name';
        }
        field(3; "Trigger Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Trigger Name';
        }
        field(4; Timestamp; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Timestamp';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    var
        myInt: Integer;

    procedure InsertLogEntry(ObjectName: Text[100]; TriggerName: Text[100])
    var
        TriggerLog: Record "Trigger Log";
        EntryNo: Integer;
    begin
        if TriggerLog.FindLast() then
            EntryNo := TriggerLog."Entry No." + 1
        else
            EntryNo := 1;

        Clear(TriggerLog);
        TriggerLog.Init;
        TriggerLog."Entry No." := EntryNo;
        TriggerLog."Object Name" := ObjectName;
        TriggerLog."Trigger Name" := TriggerName;
        TriggerLog.Timestamp := CurrentDateTime();
        TriggerLog.Insert();
        Clear(TriggerLog);
    end;

    procedure ClearLogEntries()
    var
        TriggerLog: Record "Trigger Log";
    begin
        if TriggerLog.Count() > 0 then TriggerLog.DeleteAll();
    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}