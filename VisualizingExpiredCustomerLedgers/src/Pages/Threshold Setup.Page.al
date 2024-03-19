page 50110 "Threshold Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Threshold Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Threshold Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Threshold 1 Value"; Rec."Threshold 1 Value")
                {
                    ToolTip = 'Specifies the value of the Threshold 1 Value field.';
                }
                field("Threshold 1 Style"; Rec."Threshold 1 Style")
                {
                    ToolTip = 'Specifies the value of the Threshold 1 Style field.';
                }
                field("Threshold 2 Value"; Rec."Threshold 2 Value")
                {
                    ToolTip = 'Specifies the value of the Threshold 2 Value field.';
                }
                field("Threshold 2 Style"; Rec."Threshold 2 Style")
                {
                    ToolTip = 'Specifies the value of the Threshold 2 Style field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        TresholdSetupRec: Record "Threshold Setup";
    begin
        if TresholdSetupRec.IsEmpty() then begin
            Clear(TresholdSetupRec);
            TresholdSetupRec."Primary Key" := 'THRSH01';
            TresholdSetupRec."Threshold 1 Value" := 1;
            TresholdSetupRec."Threshold 1 Style" := "Style Type"::None;
            TresholdSetupRec."Threshold 2 Value" := 2;
            TresholdSetupRec."Threshold 2 Style" := "Style Type"::Ambiguous;
            TresholdSetupRec.Insert();
        end;
    end;
}