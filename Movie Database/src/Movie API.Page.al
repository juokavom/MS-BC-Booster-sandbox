page 50123 "Movie API"
{
    // Endpoint (OnPrem): http://bcserver-default:7048/BC/api/JokubasAkramasNavitrans/entertainment/v1.0/companies(c34a8fb6-12e5-ee11-a201-6045bdac9446)/movies
    PageType = API;
    APIPublisher = 'JokubasAkramasNavitrans';
    APIGroup = 'entertainment';
    APIVersion = 'v1.0';
    EntityName = 'movie';
    EntitySetName = 'movies';
    DelayedInsert = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Movie;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(year; Rec.Year)
                {
                    Caption = 'Year';
                }
                field(genre; Rec.Genre)
                {
                    Caption = 'Genre';
                }
                field(production; Rec.Production)
                {
                    Caption = 'Production';
                }
                field(actors; Rec.Actors)
                {
                    Caption = 'Actors';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(score; Rec.Score)
                {
                    Caption = 'Score';
                }
            }
        }
    }
}