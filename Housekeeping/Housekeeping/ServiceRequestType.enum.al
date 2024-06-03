enum 50200 "Service Request Type"
{
    Extensible = true;
    Caption = 'Service Request Type';

    value(0; None)
    {
        Caption = '---';
    }
    value(1; Daily)
    {
        Caption = 'Daily Cleaning';
    }
    value(2; Final)
    {
        Caption = 'Final Cleaning';
    }
    value(3; Prepare)
    {
        Caption = 'Prepare for Arrival';
    }
    value(4; FinalAndPrepare)
    {
        Caption = 'Final Cleaning and Prepare for Arrival';
    }
}