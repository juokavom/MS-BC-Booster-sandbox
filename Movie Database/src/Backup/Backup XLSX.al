codeunit 50122 "Backup XLSX" implements IBackup
{
    procedure Backup(Movie: Record Movie): Boolean
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
    begin
        BuildExcelData(Movie, TempExcelBuffer);
        ExportExcelFile(TempExcelBuffer);
    end;

    local procedure ExportExcelFile(var TempExcelBuffer: Record "Excel Buffer" temporary)
    var
        MovieBackup: Label 'Movie Backup';
        FileNameTitle: Label 'Movie_Export_%1', Comment = '%1 - DateTime of export';
        FileName: Text;
    begin
        FileName := StrSubstNo(FileNameTitle, Format(CurrentDateTime));
        TempExcelBuffer.CreateNewBook(MovieBackup);
        TempExcelBuffer.WriteSheet(MovieBackup, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(FileName);
        TempExcelBuffer.OpenExcel();
    end;

    local procedure BuildExcelData(Movie: Record Movie; var TempExcelBuffer: Record "Excel Buffer" temporary)
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();

        TempExcelBuffer.NewRow();

        AddExcelCell(TempExcelBuffer, Movie.FieldCaption("No."), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Title), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Year), TempExcelBuffer."Cell Type"::Number, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Genre), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Actors), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Production), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Description), TempExcelBuffer."Cell Type"::Text, true);
        AddExcelCell(TempExcelBuffer, Movie.FieldCaption(Score), TempExcelBuffer."Cell Type"::Number, true);

        repeat
            TempExcelBuffer.NewRow();
            AddExcelCell(TempExcelBuffer, Movie."No.", TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Title, TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Year, TempExcelBuffer."Cell Type"::Number, false);
            AddExcelCell(TempExcelBuffer, Movie.Genre, TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Actors, TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Production, TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Description, TempExcelBuffer."Cell Type"::Text, false);
            AddExcelCell(TempExcelBuffer, Movie.Score, TempExcelBuffer."Cell Type"::Number, false);
        until Movie.Next() = 0;
    end;

    local procedure AddExcelCell(var TempExcelBuffer: Record "Excel Buffer" temporary; Value: Variant; CellType: Option; IsBold: Boolean)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', IsBold, false, false, '', CellType);
    end;
}