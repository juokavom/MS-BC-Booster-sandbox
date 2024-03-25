page 50132 "Grade Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Grade Setup";
    Caption = 'Grade Setup Card';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                    ApplicationArea = All;
                }
                field("Grade Nos."; Rec."Grade Nos.")
                {
                    ToolTip = 'Specifies the value of the Grade Nos. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        GradeSetupRec: Record "Grade Setup";
    begin
        if not GradeSetupRec.Get() then begin
            Clear(GradeSetupRec);
            GradeSetupRec.Init();
            GradeSetupRec.Insert();
        end;
    end;
}