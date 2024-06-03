table 50201 "Service Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; RoomNo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Room No.';
            TableRelation = Room."No.";
        }
        field(10; ServiceRequestType; Enum "Service Request Type")
        {
            DataClassification = SystemMetadata;
            Caption = 'Requested Service';

            trigger OnValidate()
            var
                Room: Record Room;
                RequestAllowed: Boolean;
                WrongStatusErr: Label 'Status can not be %1 when requesting %2! (Room %3)', Comment = '%1=current status, %2=requested service, %3=room no.';
            begin
                Room.Get(RoomNo);
                case ServiceRequestType of
                    ServiceRequestType::Daily:
                        RequestAllowed := (Room.Status = Room.Status::InUse);
                    ServiceRequestType::Final:
                        RequestAllowed := (Room.Status in [Room.Status::InUse, Room.Status::DailyClean]);
                    ServiceRequestType::FinalAndPrepare:
                        RequestAllowed := (Room.Status in [Room.Status::InUse, Room.Status::DailyClean]);
                    ServiceRequestType::Prepare:
                        RequestAllowed := (Room.Status = Room.Status::Clean);
                end;
                if not RequestAllowed then
                    Error(WrongStatusErr, Room.Status, ServiceRequestType, Room."No.");
            end;
        }
        field(20; Started; Boolean)
        {
            DataClassification = SystemMetadata;
            Caption = 'Started';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; RoomNo)
        {
            Clustered = true;
        }
    }
}