table 50200 Room
{
    DataClassification = CustomerContent;
    Caption = 'Room';

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(10; Status; Enum "Room Status")
        {
            DataClassification = SystemMetadata;
            Caption = 'Room Status';
        }
        field(100; ExistingServiceRequest; Enum "Service Request Type")
        {
            Caption = 'Service Requested';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Service Request".ServiceRequestType where(RoomNo = field("No.")));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        Request(enum::"Service Request Type"::None); // deletes existing service request, if any
    end;

    procedure Request(ServiceRequestType: Enum "Service Request Type")
    var
        Housekeeping: Codeunit Housekeeping;
    begin
        Housekeeping.Request(Rec, ServiceRequestType);
    end;
}