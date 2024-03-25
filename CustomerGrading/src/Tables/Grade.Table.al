table 50130 Grade
{
    DataClassification = CustomerContent;
    LookupPageId = "Grade List";
    DrillDownPageId = "Grade List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Grade Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
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
        fieldgroup(DropDown; "No.", Description) { }
        fieldgroup(Brick; "No.", Description) { }
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Grade Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Grade Nos.",
                                   xRec."No. Series",
                                   0D,
                                   "No.",
                                   "No. Series");
        end;
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

    procedure AssistEdit(OldCust: Record Grade): Boolean
    var
        Grade: Record Grade;
    begin
        Grade := Rec;
        SalesSetup.Get();
        SalesSetup.TestField("Grade Nos.");
        if NoSeriesMgt.SelectSeries(SalesSetup."Grade Nos.",
                                    OldCust."No. Series",
                                    "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            Rec := Grade;
            exit(true);
        end;
    end;
}