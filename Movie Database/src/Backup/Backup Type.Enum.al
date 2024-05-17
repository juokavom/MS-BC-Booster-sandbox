enum 50121 "Backup Type" implements IBackup
{
    Extensible = true;

    value(0; CSV)
    {
        Caption = 'CSV';
        Implementation = IBackup = "Backup CSV";
    }
    value(1; XLSX)
    {
        Caption = 'XLSX';
        Implementation = IBackup = "Backup XLSX";
    }
    value(2; JSON)
    {
        Caption = 'JSON';
        Implementation = IBackup = "Backup JSON";
    }
    value(3; XML)
    {
        Caption = 'XML';
        Implementation = IBackup = "Backup XML";
    }
}