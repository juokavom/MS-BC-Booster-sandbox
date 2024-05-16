table 50120 Movie
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Movie List";
    LookupPageId = "Movie List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Title; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(3; Year; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
        }
        field(4; Genre; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Genre';
        }
        field(5; "Actors"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Actors';
        }
        field(6; "Production"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Production';
        }
        field(7; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(8; "Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(9; "Image"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Image';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "No.", Title, Year, Genre, Score, Image) { }
        fieldgroup(DropDown; "No.", Title, Year) { }
    }
}