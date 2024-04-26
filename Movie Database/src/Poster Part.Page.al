page 50122 "Poster Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Movie;

    layout
    {
        area(Content)
        {
            cuegroup(Poster)
            {
                field(PosterField; Rec.Image)
                {
                    ApplicationArea = All;
                    Caption = 'Movie Poster';
                }
            }
        }
    }

}