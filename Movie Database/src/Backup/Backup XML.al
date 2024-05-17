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

// If requesting support, please provide the following details to help troubleshooting:

// Error message: 
// Microsoft.Dynamics.Nav.Runtime.NavXmlAttributeCollection variable not initialized.

// Internal session ID: 
// 4adfe512-abf2-404c-853a-85372a7ff5f2

// Application Insights session ID: 
// d4e0bb73-0bcc-41db-a1f4-c0db5d8c6b2f

// Client activity id: 
// e48e8e93-f63a-4b7b-86b4-293478f1054f

// Time stamp on error: 
// 2024-05-17T12:12:50.4721314Z

// User telemetry id: 
// b58d06ab-1616-40d9-b9fb-bf4f3646660b

// AL call stack: 
// "Backup XML"(CodeUnit 50124).BuildMovieJsonBackup line 17 - Movie Database by Jokubas Akramas Navitrans
// "Backup XML"(CodeUnit 50124).Backup line 7 - Movie Database by Jokubas Akramas Navitrans
// "Movie List"(Page 50121).RunBackupMovies line 9 - Movie Database by Jokubas Akramas Navitrans
// "Movie List"(Page 50121)."BackupMovies - OnAction"(Trigger) line 2 - Movie Database by Jokubas Akramas Navitrans

