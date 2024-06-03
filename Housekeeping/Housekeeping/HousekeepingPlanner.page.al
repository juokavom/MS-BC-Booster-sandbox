page 50200 "Housekeeping Planner"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Room;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Rooms)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Room No.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(ServiceRequested; Rec.ExistingServiceRequest)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DailyCleaning)
            {
                ApplicationArea = All;
                Caption = 'Daily Cleaning';
                Image = Period;

                trigger OnAction()
                begin
                    Rec.Request(ServiceRequestType::Daily);
                end;
            }
            action(FinalCleaning)
            {
                ApplicationArea = All;
                Caption = 'Final Cleaning';
                Image = ClosePeriod;

                trigger OnAction()
                begin
                    Rec.Request(ServiceRequestType::Final);
                end;
            }
            action(FinalCleaningAndPrepare)
            {
                ApplicationArea = All;
                Caption = 'Final Cleaning And Prepare';
                Image = PeriodStatus;

                trigger OnAction()
                begin
                    Rec.Request(ServiceRequestType::FinalAndPrepare);
                end;
            }
            action(PrepareForArrival)
            {
                ApplicationArea = All;
                Caption = 'Prepare For Arrival';
                Image = PersonInCharge;

                trigger OnAction()
                begin
                    Rec.Request(ServiceRequestType::Prepare);
                end;
            }
            action(CancelRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel request';
                Image = Cancel;

                trigger OnAction()
                begin
                    Rec.Request(ServiceRequestType::None);
                end;
            }
        }
    }

    var
        ServiceRequestType: Enum "Service Request Type";
}