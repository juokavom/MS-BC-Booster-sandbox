page 50120 "Movie Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Movie;
    Caption = 'Movie';

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the value of the Genre field.';
                }
                field(Actors; Rec.Actors)
                {
                    ToolTip = 'Specifies the value of the Actors field.';
                }
                field(Production; Rec.Production)
                {
                    ToolTip = 'Specifies the value of the Production field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    MultiLine = true;
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }

        area(FactBoxes)
        {
            part("Poster Part"; "Poster Part")
            {
                Caption = 'Movie Poster';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}