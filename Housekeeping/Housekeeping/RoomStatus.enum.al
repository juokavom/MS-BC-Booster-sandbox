enum 50201 "Room Status"
{
    Extensible = true;
    Caption = 'Room Status';

    value(0; undefined)
    {
        Caption = 'Undefined';
    }
    value(1; InUse)
    {
        Caption = 'In Use';
    }
    value(2; DailyClean)
    {
        Caption = 'Daily Clean';
    }
    value(3; Clean)
    {
        Caption = 'Clean';
    }
    value(4; Prepared)
    {
        Caption = 'Prepared';
    }
    value(5; WorkInProgress)
    {
        Caption = 'Work in progress';
    }
}