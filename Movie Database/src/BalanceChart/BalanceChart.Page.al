page 50127 "Balance Chart"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Balance Chart';

    layout
    {
        area(Content)
        {
            usercontrol(ChartC; "Chart Control")
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    DrawChart();
                end;
            }
        }
    }

    local procedure DrawChart()
    var
        Customer: Record Customer;
        Names, Balances : JsonArray;
        NameValue, BalanceValue : JsonValue;
    begin
        Customer.SetFilter("Balance (LCY)", '>%1', 0);
        if Customer.FindSet() then
            repeat
                Customer.CalcFields(Customer."Balance (LCY)");
                NameValue.SetValue(Customer.Name);
                BalanceValue.SetValue(Customer."Balance (LCY)");
                Names.Add(NameValue.Clone());
                Balances.Add(BalanceValue.Clone());
            until Customer.Next() = 0;

        CurrPage.ChartC.drawChart(Names, Balances);
    end;
}