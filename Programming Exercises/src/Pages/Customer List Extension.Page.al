pageextension 55101 "Customer List Extension" extends "Customer List"
{
    actions
    {
        addfirst("&Customer")
        {
            action(MyCustomAction)
            {
                Caption = 'My Custom Action';
                RunObject = codeunit "Variables And Datatypes";
                ApplicationArea = All;
            }
        }
    }
}