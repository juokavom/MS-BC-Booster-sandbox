codeunit 50200 Housekeeping
{
    trigger OnRun()
    begin

    end;

    procedure Request(Room: Record Room; ServiceRequestType: Enum "Service Request Type")
    var
        ServiceRequest: Record "Service Request";
        ChangeNotAllowedErr: Label 'Changing from %1 to %2 is not allowed!', Comment = '%1=current service request type, %2=new service request type';
    begin
        if ServiceRequest.Get(Room."No.") then begin
            case ServiceRequestType of
                ServiceRequestType::None:
                    ServiceRequest.Delete();
                ServiceRequest.ServiceRequestType:
                    ; // same request as existing; ignore
                else
                    if ServiceRequestTypeChangeAllowed(ServiceRequest.ServiceRequestType, ServiceRequestType) then begin
                        ServiceRequest.Validate(ServiceRequestType, ServiceRequestType);
                        ServiceRequest.Modify();
                    end else
                        Error(ChangeNotAllowedErr, ServiceRequest.ServiceRequestType, ServiceRequestType);
            end
        end else
            CreateNewServiceRequest(Room, ServiceRequestType);
    end;

    local procedure CreateNewServiceRequest(Room: Record Room; ServiceRequestType: Enum "Service Request Type")
    var
        ServiceRequest: Record "Service Request";
    begin
        if ServiceRequestType <> ServiceRequestType::None then begin
            ServiceRequest.Init();
            ServiceRequest.RoomNo := Room."No.";
            ServiceRequest.Validate(ServiceRequestType, ServiceRequestType);
            ServiceRequest.Insert();
        end;
    end;

    local procedure ServiceRequestTypeChangeAllowed(FromType: enum "Service Request Type"; var ToType: enum "Service Request Type") Allowed: Boolean
    begin
        // so far no other special conditions apply;
        if (FromType = enum::"Service Request Type"::Final) and (ToType = enum::"Service Request Type"::Prepare) then
            ToType := enum::"Service Request Type"::FinalAndPrepare;
        Allowed := true;
    end;

    procedure StartService(var Room: Record Room)
    var
        ServiceRequest: Record "Service Request";
        ServeceRequestNotFoundErr: Label 'There is no current service request for room %1', Comment = '%1=Room No.';
        ServiceWasStartedErr: Label 'This service request was already started.';
    begin
        if not ServiceRequest.Get(Room."No.") then
            Error(ServeceRequestNotFoundErr, Room."No.");

        if ServiceRequest.Started then
            Error(ServiceWasStartedErr);

        Room.Validate(Status, enum::"Room Status"::WorkInProgress);
        Room.Modify();
        ServiceRequest.Started := true;
        ServiceRequest.Modify()
    end;

    procedure CompleteService(var Room: Record Room)
    var
        ServiceRequest: Record "Service Request";
        ServiceRequestNotFoundErr: Label 'There is no current service request for room %1', Comment = '%1=Room No.';
        ServiceNotStartedErr: Label 'This service request is not started.';
    begin
        if not ServiceRequest.Get(Room."No.") then
            Error(ServiceRequestNotFoundErr, Room."No.");

        if not ServiceRequest.Started then
            Error(ServicenotStartedErr);

        Case ServiceRequest.ServiceRequestType of
            "Service Request Type"::Daily:
                Room.Status := "Room Status"::DailyClean;
            "Service Request Type"::Final:
                Room.Status := "Room Status"::Clean;
            "Service Request Type"::Prepare, "Service Request Type"::FinalAndPrepare:
                Room.Status := "Room Status"::Prepared;
        End;
        Room.Modify();
        ServiceRequest.Delete();
    end;
}