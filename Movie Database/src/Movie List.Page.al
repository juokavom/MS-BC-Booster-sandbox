page 50121 "Movie List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Movie;
    Caption = 'Movies';
    CardPageId = "Movie Card";

    layout
    {
        area(Content)
        {
            repeater(General)
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
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }
    }
}