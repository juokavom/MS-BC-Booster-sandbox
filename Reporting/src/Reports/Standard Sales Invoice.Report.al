reportextension 50140 StandardSalesInvoice extends "Standard Sales - Invoice"
{
    RDLCLayout = './src/Reports/StandardSalesInvoiceExtended.rdl';

    dataset
    {
        add(Line)
        {
            column(Order_No_Line_Lbl; Line.FieldCaption("Order No."))
            { }
            column(Order_No_Line; Line."Order No.")
            { }
            column(DisplayOrderInfo; DisplayOrderInfo)
            { }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(DisplayOrderInfo; DisplayOrderInfo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Order Information';
                    ToolTip = 'Specifies if you want Order Information to be shown on the document.';
                }
            }
        }
    }

    var
        DisplayOrderInfo: Boolean;
}