codeunit 50100 "Housekeeping UI Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        // [FEATURE] Housekeeping Requests
    end;

    var
        Room: Record Room;
        ServiceRequest: Record "Service Request";
        Any: Codeunit Any;
        LibraryAssert: Codeunit "Library Assert";
        HousekeepingPlannerTestPage: TestPage "Housekeeping Planner";
        WrongServiceRequestTypeErr: Label 'Wrong service request type found!';
        UnexpectedRecordExistsErr: Label 'Unexpected record exists!';

    [Test]
    procedure RequestFinalCleaningForUsedRoom()
    begin
        // [SCENARIO 001] request final cleaning for room without existing requests

        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);

        // [GIVEN] no existing requests for this room
        DeleteRequestsForRoom(Room);

        // [WHEN] the planner selects “Final Cleaning” for the room 
        HousekeepingPlannerSelectsFinalCleaning(Room);

        // [THEN] a final cleaning request is added to the request list
        LibraryAssert.AreEqual(enum::"Service Request Type"::Final, GetServiceRequest(Room).ServiceRequestType, WrongServiceRequestTypeErr);
    end;

    [Test]
    procedure RequestFinalCleaningForUsedRoomWithDailyRequested()
    begin
        // [SCENARIO 002] request final cleaning for room with existing daily cleaning request

        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);

        // [GIVEN] existing daily cleaning request for this room
        CreateExistingRequest(Room, enum::"Service Request Type"::Daily);

        // [WHEN] the planner selects “Final Cleaning” for the room 
        HousekeepingPlannerSelectsFinalCleaning(Room);

        // [THEN] the daily cleaning request for this room is updated to a final cleaning request
        LibraryAssert.AreEqual(enum::"Service Request Type"::Final, GetServiceRequest(Room).ServiceRequestType, WrongServiceRequestTypeErr);
    end;

    [Test]
    procedure RequestPreparationForUsedRoomWithDailyRequested()
    begin
        // [SCENARIO 003] request room preparation for room with existing final cleaning request

        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);

        // [GIVEN] existing final cleaning request for this room
        CreateExistingRequest(Room, enum::"Service Request Type"::Final);

        // [WHEN] the planner selects “Prepare for arrival” for the room
        HousekeepingPlannerSelectsPrepareForArrival(Room);

        // [THEN] the existing final cleaning request is updated to ‘final cleaning and prepare for arrival’
        LibraryAssert.AreEqual(enum::"Service Request Type"::FinalAndPrepare, GetServiceRequest(Room).ServiceRequestType, WrongServiceRequestTypeErr);
    end;

    [Test]
    procedure RequestPreparationForCleanRoom()
    begin
        // [SCENARIO 004] request room preparation for a cleaned room with no existing service requests

        // [GIVEN] a room that is clean
        CreateRoomCleaned(Room);

        // [GIVEN] no existing requests for this room
        DeleteRequestsForRoom(Room);

        // [WHEN] the planner selects “Prepare for arrival” for the room 
        HousekeepingPlannerSelectsPrepareForArrival(Room);

        // [THEN] a ‘prepare for arrival’ request is added to the request list
        LibraryAssert.AreEqual(enum::"Service Request Type"::Prepare, GetServiceRequest(Room).ServiceRequestType, WrongServiceRequestTypeErr);
    end;

    [Test]
    procedure RequestPreparationForUsedRoom()
    begin
        // [SCENARIO 005] request room preparation for a room that is not cleaned and has no existing service requests

        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);

        // [GIVEN] no existing service requests for this room
        DeleteRequestsForRoom(Room);

        // [WHEN] the planner selects “Prepare for arrival” for the room
        asserterror HousekeepingPlannerSelectsPrepareForArrival(Room);

        // [THEN] an error message comes up saying “Status can not be In Use when requesting Prepare for Arrival”
        LibraryAssert.ExpectedError('Status can not be In Use when requesting Prepare for Arrival');

        // [THEN] there is no new service request added
        LibraryAssert.IsFalse(ServiceRequestExists(Room), UnexpectedRecordExistsErr);
    end;

    local procedure CreateRoomNotCleaned(var Room: Record Room)
    begin
        CreateRoom(Room);
        Room.Status := Room.Status::InUse;
        Room.Modify();
    end;

    local procedure CreateRoomCleaned(var Room: Record Room)
    begin
        CreateRoom(Room);
        Room.Status := Room.Status::Clean;
        Room.Modify();
    end;

    local procedure CreateRoom(var Room: Record Room)
    begin
        Room.Init();
        Room."No." := Any.AlphanumericText(MaxStrLen(Room."No."));
        Room.Insert();
    end;

    local procedure CreateExistingRequest(Room: Record Room; ServiceRequestType: enum "Service Request Type")
    begin
        Room.Request(ServiceRequestType);
    end;

    local procedure DeleteRequestsForRoom(Room: Record Room)
    begin
        Room.Request(enum::"Service Request Type"::None);
    end;

    local procedure HousekeepingPlannerSelectsFinalCleaning(Room: Record Room)
    begin
        HousekeepingPlannerTestPage.OpenView();
        HousekeepingPlannerTestPage.GoToRecord(Room);
        HousekeepingPlannerTestPage.FinalCleaning.Invoke();
        HousekeepingPlannerTestPage.Close();
    end;

    local procedure HousekeepingPlannerSelectsPrepareForArrival(Room: Record Room)
    begin
        HousekeepingPlannerTestPage.OpenView();
        HousekeepingPlannerTestPage.GoToRecord(Room);
        HousekeepingPlannerTestPage.PrepareForArrival.Invoke();
        HousekeepingPlannerTestPage.Close();
    end;

    local procedure GetServiceRequest(Room: Record Room) Result: Record "Service Request"
    begin
        Result.Get(Room."No.");
    end;

    local procedure ServiceRequestExists(Room: Record Room): Boolean
    var
        FoundServiceRequest: Record "Service Request";
    begin
        FoundServiceRequest.SetRange(RoomNo, Room."No.");
        exit(not FoundServiceRequest.IsEmpty());
    end;

}