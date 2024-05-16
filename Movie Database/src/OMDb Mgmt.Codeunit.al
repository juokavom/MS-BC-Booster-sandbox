codeunit 50120 "OMDb Management"
{
    trigger OnRun()
    begin
        OpenMovieDetailsDialog();
    end;

    local procedure OpenMovieDetailsDialog()
    var
        MovieDetailsDialog: Page "Movie Details Dialog";
        TitleSearchQ: Text;
    begin
        Clear(MovieDetailsDialog);
        if MovieDetailsDialog.RunModal() = Action::OK then begin
            TitleSearchQ := MovieDetailsDialog.GetMovieTitle();
            RunMovieRetrieveFlow(TitleSearchQ);
        end;
    end;

    local procedure RunMovieRetrieveFlow(TitleSearchQ: Text)
    var
        MovieList: JsonArray;
        Selected: Integer;
        ImdbId: Text;
        MovieDetails: JsonObject;
    begin
        if not ParseMovieList(SearchMovieListWithTitleCriteria(TitleSearchQ), MovieList) then exit;
        Selected := Dialog.StrMenu(GetParsedMovieList(MovieList));
        ImdbId := GetImdbIdFromResponse(MovieList, Selected - 1);
        if not ParseOMDBResponse(GetMovieDetailsById(ImdbId), MovieDetails) then exit;
        InsertNewMovie(MovieDetails);
    end;

    local procedure GetImdbIdFromResponse(MovieList: JsonArray; Index: Integer): Text
    var
        imdbIdToken: JsonToken;
        errorWhileParsingImdbidLbl: Label 'No imdbid or is not a value.';
    begin
        if not MovieList.SelectToken(StrSubstNo(('$[%1].imdbID'), Index), imdbIdToken) or not imdbIdToken.IsValue() then
            Error(errorWhileParsingImdbidLbl);
        exit(imdbIdToken.AsValue().AsText());
    end;

    local procedure GetMovieDetailsById(IMDbID: Text) JsonResult: Text
    var
        uri: Label 'http://www.omdbapi.com/?apikey=%1&i=%2', Comment = '%1 = OMDb API key, %2 = IMDbID', Locked = true;
    begin
        exit(SendRequestWithJsonResult(StrSubstNo(uri, 'fcdcd1af', IMDbID)))
    end;

    local procedure SearchMovieListWithTitleCriteria(TitleSearchQ: Text) JsonResult: Text
    var
        uri: Label 'http://www.omdbapi.com/?apikey=%1&s=%2', Comment = '%1 = OMDb API key, %2 = Movie Search Filter', Locked = true;
    begin
        exit(SendRequestWithJsonResult(StrSubstNo(uri, 'fcdcd1af', TitleSearchQ)))
    end;

    local procedure SendRequestWithJsonResult(path: Text) JsonResult: Text
    var
        client: HttpClient;
        responseMessage: HttpResponseMessage;
        badStatusCodeErrorLbl: Label 'Status Code - %1. Reason - %2';
        errorWhileRequestLbl: Label 'Error while making request to the server.';
    begin
        if not client.Get(path, responseMessage) then
            Error(errorWhileRequestLbl);
        if not responseMessage.IsSuccessStatusCode() then begin
            Error(StrSubstNo(badStatusCodeErrorLbl, Format(responseMessage.HttpStatusCode), responseMessage.ReasonPhrase()));
        end;

        responseMessage.Content().ReadAs(JsonResult);
    end;

    local procedure ParseMovieList(JsonResult: Text; var MovieList: JsonArray): Boolean
    var
        OMDbSearchObj: JsonObject;
        SearchToken: JsonToken;
        errorWhileParsingSearchLbl: Label 'No search object or is not an array.';
    begin
        if not ParseOMDBResponse(JsonResult, OMDbSearchObj) then exit(false);
        if not OMDbSearchObj.Get('Search', SearchToken) or not SearchToken.IsArray() then
            Error(errorWhileParsingSearchLbl);

        MovieList := SearchToken.AsArray();
        exit(true);
    end;

    local procedure ParseOMDBResponse(JsonResult: Text; var OMDbSearchObj: JsonObject) SuccessResponseValue: Boolean
    var
        OMDbSearchToken: JsonToken;
        ErrorWhileParsingJsonLbl: Label 'Invalid Json response.';
        SuccessResponseToken: JsonToken;
        ErrorWhileParsingResponseLbl: Label 'No response object or is not a value.';
        ErrorToken: JsonToken;
        ErrorWhileParsingErrorLbl: Label 'No error object or is not a value.';
        ErrorValue: Text;
    begin
        if not OMDbSearchToken.ReadFrom(JsonResult) or not OMDbSearchToken.IsObject() then
            Error(errorWhileParsingJsonLbl);

        OMDbSearchObj := OMDbSearchToken.AsObject();

        if not OMDbSearchObj.Get('Response', SuccessResponseToken) or not SuccessResponseToken.IsValue() then
            Error(errorWhileParsingResponseLbl);

        SuccessResponseValue := SuccessResponseToken.AsValue().AsBoolean();

        if not SuccessResponseValue then begin
            if not OMDbSearchObj.Get('Error', ErrorToken) or not ErrorToken.IsValue() then
                Error(errorWhileParsingErrorLbl);

            ErrorValue := ErrorToken.AsValue().AsText();

            Error(ErrorValue);
        end
    end;


    local procedure InsertNewMovie(MovieDetails: JsonObject): Text
    var
        Movie: Record Movie;
    begin
        Clear(Movie);

        Movie."No." := GetFieldValueFromObject(MovieDetails, 'imdbID').AsCode();
        Movie.Title := GetFieldValueFromObject(MovieDetails, 'Title').AsText();
        Movie.Year := GetFieldValueFromObject(MovieDetails, 'Year').AsInteger();
        Movie.Genre := GetFieldValueFromObject(MovieDetails, 'Genre').AsText();
        Movie.Actors := GetFieldValueFromObject(MovieDetails, 'Actors').AsText();
        Movie.Production := GetFieldValueFromObject(MovieDetails, 'Production').AsText();
        Movie.Description := GetFieldValueFromObject(MovieDetails, 'Plot').AsText();

        Movie.Score := ParseIMDBScore(MovieDetails);

        SetMoviePoster(GetFieldValueFromObject(MovieDetails, 'Poster').AsText(), Movie);

        Movie.Insert();
    end;


    local procedure SetMoviePoster(PosterUrl: Text; var Movie: Record Movie)
    var
        InStr: InStream;
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
    begin
        if HttpClient.Get(PosterUrl, Response) AND Response.Content().ReadAs(InStr) then begin
            Clear(Movie.Image);
            Movie.Image.ImportStream(InStr, 'Poster of Movie ' + Movie.Title);
        end;
    end;


    local procedure ParseIMDBScore(MovieDetails: JsonObject) IMDBScore: Decimal
    var
        RatingsToken: JsonToken;
        ErrorWhileParsingRatingsLbl: Label 'No ratings object or is not an array.';
        RatingsArray: JsonArray;
        RatingToken: JsonToken;
        RatingObject: JsonObject;
        IMDBValue: Text;
    begin
        if not MovieDetails.Get('Ratings', RatingsToken) or not RatingsToken.IsArray() then
            Error(ErrorWhileParsingRatingsLbl);

        RatingsArray := RatingsToken.AsArray();

        foreach RatingToken in RatingsArray do begin
            if (RatingToken.IsObject()) then begin
                RatingObject := RatingToken.AsObject();

                if GetFieldValueFromObject(RatingObject, 'Source').AsText() = 'Internet Movie Database' then begin
                    IMDBValue := GetFieldValueFromObject(RatingObject, 'Value').AsText();
                    IMDBValue := IMDBValue.Split('/').Get(1);
                    Evaluate(IMDBScore, IMDBValue);
                    exit(IMDBScore);
                end;
            end;
        end;
    end;


    local procedure GetFieldValueFromObject(ParentObj: JsonObject; FieldName: Text): JsonValue
    var
        FieldToken: JsonToken;
        ErrorWhileParsingFieldValueLbl: Label 'Field %1 is not a valid value', Comment = '%1 - Parsed value from object';
    begin
        if ParentObj.Get(FieldName, FieldToken) and FieldToken.IsValue() then
            exit(FieldToken.AsValue());
        Error(ErrorWhileParsingFieldValueLbl, FieldName);
    end;

    local procedure GetParsedMovieList(MovieList: JsonArray): Text
    var
        Index: Integer;
        MovieToken: JsonToken;
        MovieObj: JsonObject;
        MovieTitleToken: JsonToken;
        MovieTitleList: TextBuilder;
    begin
        Clear(MovieTitleList);
        foreach MovieToken in MovieList do begin
            if (MovieToken.IsObject()) then begin
                MovieObj := MovieToken.AsObject();
                if MovieObj.Get('Title', MovieTitleToken) and MovieTitleToken.IsValue() then
                    MovieTitleList.Append(MovieTitleToken.AsValue().AsText() + ', ');
            end;
        end;
        exit(MovieTitleList.ToText().TrimEnd(', '));
    end;
}