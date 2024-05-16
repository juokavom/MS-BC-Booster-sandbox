page 50122 "Poster Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Movie;

    layout
    {
        area(Content)
        {
            field(PosterField; Rec.Image)
            {
                ApplicationArea = All;
                Caption = 'Movie Poster';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Upload)
            {
                ApplicationArea = All;
                Caption = 'Upload Poster';
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    UploadPoster();
                end;
            }
        }
    }


    procedure UploadPoster()
    var
        InStr: InStream;
        FileName: Text;
    begin
        if File.UploadIntoStream('Import Movie Poster', '', 'JPG Files (*.jpg)|*.jpg', FileName, InStr) then begin
            Clear(Rec.Image);
            Rec.Image.ImportStream(InStr, Rec.Title);
            Rec.Modify();
        end;
    end;
}