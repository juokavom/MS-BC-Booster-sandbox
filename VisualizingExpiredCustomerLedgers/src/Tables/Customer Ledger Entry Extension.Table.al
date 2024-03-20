tableextension 50115 "Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    procedure GetNumberOfDaysExpired(): Integer
    var
        ExpiredDays: Integer;
    begin
        ExpiredDays := Today() - Rec."Due Date";
        if ExpiredDays < 0 then ExpiredDays := 0;
        exit(Abs(ExpiredDays));
    end;
}