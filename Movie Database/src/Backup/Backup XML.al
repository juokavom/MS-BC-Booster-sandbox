codeunit 50124 "Backup XML" implements IBackup
{
    procedure Backup(Movie: Record Movie): Boolean
    var
        MovieData: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
    begin
        OutStr := TempBlob.CreateOutStream();
        MovieData := BuildMovieJsonBackup(Movie, OutStr);
        ExportStreamToXMLFile(TempBlob.CreateInStream());
    end;

    local procedure ExportStreamToXMLFile(InStr: InStream)
    var
        FileNameTitle: Label 'Movie_Export_%1.xml', Comment = '%1 - DateTime of export';
        FileName: Text;
    begin
        FileName := StrSubstNo(FileNameTitle, Format(CurrentDateTime));
        File.DownloadFromStream(
            InStr,
            '',
            '',
            '',
            FileName
        );
    end;

    local procedure BuildMovieJsonBackup(Movie: Record Movie; var OutStr: OutStream) MovieData: Text
    var
        MoviesLbl: Label 'Movies';
        XmlDoc: XmlDocument;
        Declaration: XmlDeclaration;
        MoviesEl: XmlElement;
        MovieEl: XmlElement;
    begin
        XmlDoc := XmlDocument.Create();

        Declaration := XmlDeclaration.Create('1.0', 'utf-8', 'yes');
        XmlDoc.SetDeclaration(Declaration);

        MoviesEl := XmlElement.Create(MoviesLbl);

        repeat
            Clear(MovieEl);
            MovieEl := XmlElement.Create('Movie');

            MovieEl.SetAttribute(Movie.FieldCaption("No."), Movie."No.");
            MovieEl.SetAttribute(Movie.FieldCaption(Title), Movie.Title);
            MovieEl.SetAttribute(Movie.FieldCaption(Year), Format(Movie.Year));
            MovieEl.SetAttribute(Movie.FieldCaption(Genre), Movie.Genre);
            MovieEl.SetAttribute(Movie.FieldCaption(Actors), Movie.Actors);
            MovieEl.SetAttribute(Movie.FieldCaption(Production), Movie.Production);
            MovieEl.SetAttribute(Movie.FieldCaption(Description), Movie.Description);
            MovieEl.SetAttribute(Movie.FieldCaption(Score), Format(Movie.Score));

            MoviesEl.Add(MovieEl);
        until Movie.Next() = 0;

        XmlDoc.Add(MoviesEl);

        MoviesEl.WriteTo(OutStr);
    end;
}