page 50124 "Movie Details Dialog"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Edit - Get movie details from OMDb';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(MovieTitle; MovieTitle)
                {
                    ApplicationArea = All;
                    Caption = 'Movie Title';
                }
            }
        }
    }

    var
        MovieTitle: Text;

    procedure GetMovieTitle(): Text
    begin
        exit(MovieTitle);
    end;
}