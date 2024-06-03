controladdin "Chart Control"
{
    RequestedHeight = 600;
    MinimumHeight = 400;
    MaximumHeight = 600;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    StartupScript = 'src/BalanceChart/start.js';
    Scripts = 'https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js', 'src/BalanceChart/chartbc.js';

    event ControlReady();

    procedure drawChart(Names: JsonArray; Balances: JsonArray);
}