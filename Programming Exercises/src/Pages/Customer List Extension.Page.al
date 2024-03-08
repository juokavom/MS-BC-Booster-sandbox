pageextension 55101 "Customer List Extension" extends "Customer List"
{
    actions
    {
        addfirst("&Customer")
        {
            action(MyCustomAction)
            {
                ApplicationArea = All;
                Caption = 'My Custom Action';
                Image = Action;
                RunObject = codeunit "Variables And Datatypes";
            }
        }
    }
}