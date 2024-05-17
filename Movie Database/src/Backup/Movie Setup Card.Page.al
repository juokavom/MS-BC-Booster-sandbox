page 50125 "Movie Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Movie Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Backup Type"; Rec."Backup Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit()
    begin
        if Rec.IsEmpty() then Rec.Insert();
    end;
}