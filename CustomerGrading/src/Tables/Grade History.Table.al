table 50132 "Grade History"
{
    DataClassification = CustomerContent;
    LookupPageId = "Grade History List";
    DrillDownPageId = "Grade History List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Document Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(5; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(6; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(7; DateTime; dateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'DateTime';
        }
        field(8; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(9; "Grade"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(10; "Grade Description"; Text[100])
        {
            Caption = 'Grade Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Grade.Description where("No." = field(Grade)));
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

    procedure InsertIntoGradeHistory(
        "Prop Document Type": Text[100];
        "Prop Document No.": Code[20];
        "Prop Document Date": Date;
        "Prop Customer No.": Code[20];
        "Prop Grade": Code[20]
        )
    var
        GradeHistoryRec: Record "Grade History";
        NewEntryNo: Integer;
    begin
        Clear(GradeHistoryRec);

        NewEntryNo := 1;
        if GradeHistoryRec.FindLast() then begin
            NewEntryNo := GradeHistoryRec."Entry No." + 1;
        end;

        Clear(GradeHistoryRec);

        GradeHistoryRec."Entry No." := NewEntryNo;
        GradeHistoryRec."Document Type" := "Prop Document Type";
        GradeHistoryRec."Document No." := "Prop Document No.";
        GradeHistoryRec."Document Date" := "Prop Document Date";
        GradeHistoryRec."Customer No." := "Prop Customer No.";
        GradeHistoryRec.DateTime := CurrentDateTime();
        GradeHistoryRec."User ID" := CopyStr(UserId(), 1, MaxStrLen(Rec."User ID"));
        GradeHistoryRec.Grade := "Prop Grade";

        GradeHistoryRec.Insert();
        Clear(GradeHistoryRec);
    end;
}