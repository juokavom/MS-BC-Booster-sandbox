page 55100 "Expression Calculator"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Expression Calculator';

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(FirstInput; FirstInput)
                {
                    ApplicationArea = All;
                    Caption = 'First';
                }
                field(SecondInput; SecondInput)
                {
                    ApplicationArea = All;
                    Caption = 'Second';
                }
            }
            group(Output)
            {
                Caption = 'Output';
                Editable = false;
                group(Left)
                {
                    Caption = 'Left';
                    field(Result; Result)
                    {
                        Caption = 'Result';
                        ApplicationArea = All;
                    }
                }
                group(Right)
                {
                    Caption = 'Right';
                    field(IsBigger; IsBigger)
                    {
                        Caption = 'IsBigger';
                        ApplicationArea = All;
                    }
                    field(IsSmaller; IsSmaller)
                    {
                        Caption = 'IsSmaller';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Plus)
            {
                ApplicationArea = All;
                Caption = '+';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput + SecondInput;
                end;
            }
            action(Minus)
            {
                ApplicationArea = All;
                Caption = '-';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput - SecondInput;
                end;
            }
            action(Multiply)
            {
                ApplicationArea = All;
                Caption = '*';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput * SecondInput;
                end;
            }
            action(Division)
            {
                ApplicationArea = All;
                Caption = '/';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput / SecondInput;
                end;
            }
            action(">")
            {
                ApplicationArea = All;
                Caption = '>';
                Image = Calculate;

                trigger OnAction()
                begin
                    IsBigger := FirstInput > SecondInput;
                    IsSmaller := FirstInput < SecondInput;
                end;
            }
            action("<")
            {
                ApplicationArea = All;
                Caption = '<';
                Image = Calculate;

                trigger OnAction()
                begin
                    IsBigger := FirstInput < SecondInput;
                    IsSmaller := FirstInput > SecondInput;
                end;
            }
            action(MOD)
            {
                ApplicationArea = All;
                Caption = 'MOD';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput MOD SecondInput;
                end;
            }
            action(DIV)
            {
                ApplicationArea = All;
                Caption = 'DIV';
                Image = Calculate;

                trigger OnAction()
                begin
                    Result := FirstInput DIV SecondInput;
                end;
            }
        }
    }

    var
        /*
        These fields cannot be Integer because if division of 5/6 takes place, 
        the answer is an ERROR: Overflow under conversion 
        of Microsoft.Dynamics.Nav.Runtime.Decimal18 
        value 0.833333333333333333 to System.Int32.
        */
        FirstInput, SecondInput, Result : Decimal;

        IsBigger, IsSmaller : Boolean;
}