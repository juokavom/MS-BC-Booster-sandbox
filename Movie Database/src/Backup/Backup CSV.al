codeunit 50121 "Backup CSV" implements IBackup
{
    procedure Backup(Movie: Record Movie): Boolean
    var
        CSVText: Text;
    begin
        CSVText := BuildCSVExportText(Movie);
        ExportTextToCSVFile(CSVText);
    end;

    local procedure ExportTextToCSVFile(CSVText: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        FileNameTitle: Label 'Movie_Export_%1.csv', Comment = '%1 - DateTime of export';
        FileName: Text;
    begin
        FileName := StrSubstNo(FileNameTitle, Format(CurrentDateTime));
        TempBlob.CreateOutStream().WriteText(CSVText);
        File.DownloadFromStream(
            TempBlob.CreateInStream(),
            '',
            '',
            '',
            FileName
        );
    end;

    local procedure BuildCSVExportText(Movie: Record Movie): Text
    var
        CSVBuilder: TextBuilder;
    begin
        CSVBuilder.Clear();

        AppendCSVValue(CSVBuilder, Movie.FieldCaption("No."));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Title));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Year));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Genre));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Actors));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Production));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Description));
        AppendCSVValue(CSVBuilder, Movie.FieldCaption(Score));

        CSVBuilder.AppendLine();

        repeat
            AppendCSVValue(CSVBuilder, Movie."No.");
            AppendCSVValue(CSVBuilder, Movie.Title);
            AppendCSVValue(CSVBuilder, Format(Movie.Year));
            AppendCSVValue(CSVBuilder, Movie.Genre);
            AppendCSVValue(CSVBuilder, Movie.Actors);
            AppendCSVValue(CSVBuilder, Movie.Production);
            AppendCSVValue(CSVBuilder, Movie.Description);
            AppendCSVValue(CSVBuilder, Format(Movie.Score));
            CSVBuilder.AppendLine();
        until Movie.Next() = 0;

        exit(CSVBuilder.ToText());
    end;

    local procedure AppendCSVValue(var CSVBuilder: TextBuilder; TextValue: Text)
    var
        ValueAppendFormat: Text;
    begin
        ValueAppendFormat := '%1, ';
        TextValue := TextValue.Replace(',', ' ');
        CSVBuilder.Append(StrSubstNo(ValueAppendFormat, TextValue));
    end;
}