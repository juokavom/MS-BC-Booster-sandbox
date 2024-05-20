enum 50122 "Excel Doc Export Type" implements "Excel Document Export"
{
    Extensible = true;

    value(0; Browser)
    {
        Caption = 'Browser';
        Implementation = "Excel Document Export" = "Browser Excel Document Export";
    }
    value(1; Email)
    {
        Caption = 'Email';
        Implementation = "Excel Document Export" = "Email Excel Document Export";
    }
    value(2; Http)
    {
        Caption = 'Http';
        Implementation = "Excel Document Export" = "Http Excel Document Export";
    }
}