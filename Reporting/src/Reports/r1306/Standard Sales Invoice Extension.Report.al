namespace Microsoft.Sales.History;

reportextension 50143 "Standard Sales - Invoice Copy" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Header)
        {
            column(NewOrderNo; "Order No.")
            {
                Caption = 'Order No.';
            }
        }
    }


    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(ShowOrderNo; ShowOrderNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Order No.';
                    ToolTip = 'Specifies if you want to show order number in the report.';
                }
            }
        }
    }

    rendering
    {
        layout("StandardSalesInvoice.rdlc")
        {
            Type = RDLC;
            LayoutFile = './src/Reports/r1306/StandardSalesInvoice.rdlc';
            Caption = 'Standard Sales Invoice (RDLC)';
            Summary = 'The Standard Sales Invoice (RDLC) is the most detailed layout and provides most flexible layout options.';
        }
    }

    var
        ShowOrderNo: Boolean;

}

