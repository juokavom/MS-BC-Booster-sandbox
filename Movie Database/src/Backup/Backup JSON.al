codeunit 50123 "Backup JSON" implements IBackup
{
    procedure Backup(Movie: Record Movie): Boolean
    var
        MovieData: Text;
    begin
        MovieData := BuildMovieJsonBackup(Movie);
        ExportTextToJSONFile(MovieData);
    end;

    local procedure ExportTextToJSONFile(JSONText: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        FileNameTitle: Label 'Movie_Export_%1.json', Comment = '%1 - DateTime of export';
        FileName: Text;
    begin
        FileName := StrSubstNo(FileNameTitle, Format(CurrentDateTime));
        TempBlob.CreateOutStream().WriteText(JSONText);
        File.DownloadFromStream(
            TempBlob.CreateInStream(),
            '',
            '',
            '',
            FileName
        );
    end;

    local procedure BuildMovieJsonBackup(Movie: Record Movie) MovieData: Text
    var
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        MoviesLbl: Label 'Movies';
    begin
        Clear(JsonArray);

        repeat
            Clear(JsonObject);
            JsonObject.Add(Movie.FieldCaption("No."), Movie."No.");
            JsonObject.Add(Movie.FieldCaption(Title), Movie.Title);
            JsonObject.Add(Movie.FieldCaption(Year), Movie.Year);
            JsonObject.Add(Movie.FieldCaption(Genre), Movie.Genre);
            JsonObject.Add(Movie.FieldCaption(Actors), Movie.Actors);
            JsonObject.Add(Movie.FieldCaption(Production), Movie.Production);
            JsonObject.Add(Movie.FieldCaption(Description), Movie.Description);
            JsonObject.Add(Movie.FieldCaption(Score), Movie.Score);
            JsonArray.Add(JsonObject);
        until Movie.Next() = 0;


        Clear(JsonObject);

        JsonObject.Add(MoviesLbl, JsonArray);
        JsonObject.WriteTo(MovieData);
    end;
}