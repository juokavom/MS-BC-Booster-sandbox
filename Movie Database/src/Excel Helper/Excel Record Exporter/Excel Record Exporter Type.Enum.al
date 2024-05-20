enum 50123 "Excel Record Exporter Type" implements "Excel Record Exporter"
{
    Extensible = true;

    value(0; User)
    {
        Caption = 'User';
        Implementation = "Excel Record Exporter" = "User Exporter";
    }
}