enum 50120 "Excel Column Type" implements "Excel Column"
{
    Extensible = true;

    value(0; Header)
    {
        Caption = 'Header';
        Implementation = "Excel Column" = "Header Excel Col";
    }
    value(1; Number)
    {
        Caption = 'Number';
        Implementation = "Excel Column" = "Number Excel Col";
    }
    value(2; Text)
    {
        Caption = 'Text';
        Implementation = "Excel Column" = "Text Excel Col";
    }
}