table 50121 "Movie Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Backup Type"; Enum "Backup Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Backup Type';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetBackupType(): Enum "Backup Type"
    var
        BackupTypeNotFoundErrorLbl: Label 'Backup Type was not found';
    begin
        Clear(Rec);
        if Rec.FindFirst() then exit(Rec."Backup Type");
        Error(BackupTypeNotFoundErrorLbl);
    end;
}