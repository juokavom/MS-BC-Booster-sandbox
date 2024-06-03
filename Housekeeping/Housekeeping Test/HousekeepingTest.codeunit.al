codeunit 50101 "Housekeeping Test"
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
        HouseKeeping: Codeunit Housekeeping;
        Any: Codeunit Any;
        LibraryAssert: Codeunit "Library Assert";
        // HousekeepingPlannerTestPage: TestPage "Housekeeping Planner";
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

    [Test]
    procedure StartDailyCleaning()
    begin
        // [SCENARIO 006] Staff starts working on Daily Cleaning

        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);
        // [GIVEN] for this room, a service request of type “Daily Cleaning” that is not Started
        CreateExistingRequest(Room, enum::"Service Request Type"::Daily);

        // [WHEN] the housekeeping staff selects “Start Service” for the request
        HouseKeeping.StartService(Room);

        // [THEN] the room gets status “Work In Progress”
        LibraryAssert.AreEqual(enum::"Room Status"::WorkInProgress, Room.Status, 'Room Status is not updated');
        // [THEN] the service request gets status “Started”
        ServiceRequest := GetServiceRequest(Room);
        LibraryAssert.IsTrue(ServiceRequest.Started, 'Service was not started');
    end;

    [Test]
    procedure CompleteDailyCleaning()
    begin
        // [SCENARIO 007] Staff completes an active Daily Cleaning

        // [GIVEN] a room that is not cleaned and is marked “Work in Progress”
        CreateRoomWorkInProgress(Room);

        // [GIVEN] for this room, a service request of type “Daily Cleaning” that is Started
        CreateStartedExistingRequest(Room, enum::"Service Request Type"::Daily);

        // [WHEN] the housekeeping staff selects “Completed” for the request
        HouseKeeping.CompleteService(Room);

        // [THEN] the room gets status “Daily Cleaned”
        LibraryAssert.AreEqual(Enum::"Room Status"::DailyClean, Room.Status, 'Unexpected Room Status');
        // [THEN] the service request is deleted
        LibraryAssert.IsFalse(ServiceRequestExists(Room), 'There should be no Service Request remaining');
    end;

    [Test]
    procedure StartFinalCleaning()
    begin
        // [SCENARIO 008] Staff starts working on Final Cleaning
        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);
        // [GIVEN] for this room, a service request of type “Final Cleaning” that is not Started
        CreateExistingRequest(Room, enum::"Service Request Type"::Final);

        // [WHEN] the housekeeping staff selects “Start Service” for the request
        HouseKeeping.StartService(Room);

        // [THEN] the room gets status “Work In Progress”
        LibraryAssert.AreEqual(enum::"Room Status"::WorkInProgress, Room.Status, 'Room Status is not updated');
        // [THEN] the service request gets status “Started”
        ServiceRequest := GetServiceRequest(Room);
        LibraryAssert.IsTrue(ServiceRequest.Started, 'Service was not started');
    end;

    [Test]
    procedure CompleteFinalCleaning()
    begin
        // [SCENARIO 009] Staff completes an active Final Cleaning

        // [GIVEN] a room that is not cleaned and is marked “Work in Progress”
        CreateRoomWorkInProgress(Room);

        // [GIVEN] for this room, a service request of type “Final Cleaning” that is Started
        CreateStartedExistingRequest(Room, enum::"Service Request Type"::Final);

        // [WHEN] the housekeeping staff selects “Completed” for the request
        HouseKeeping.CompleteService(Room);

        // [THEN] the room gets status “Final Cleaned”
        LibraryAssert.AreEqual(Enum::"Room Status"::Clean, Room.Status, 'Unexpected Room Status');
        // [THEN] the service request is deleted
        LibraryAssert.IsFalse(ServiceRequestExists(Room), 'There should be no Service Request remaining');

    end;

    [Test]
    procedure StartPrepareForArrival()
    begin
        // [SCENARIO 010] Staff starts working on Prepare for Arrival
        // [GIVEN] a room that is Final Cleaned
        CreateRoomCleaned(Room);
        // [GIVEN] for this room, a service request of type “Prepare for Arrival” that is not Started
        CreateExistingRequest(Room, enum::"Service Request Type"::Prepare);

        // [WHEN] the housekeeping staff selects “Start Service” for the request
        HouseKeeping.StartService(Room);

        // [THEN] the room gets status “Work In Progress”
        LibraryAssert.AreEqual(enum::"Room Status"::WorkInProgress, Room.Status, 'Room Status is not updated');
        // [THEN] the service request gets status “Started”
        ServiceRequest := GetServiceRequest(Room);
        LibraryAssert.IsTrue(ServiceRequest.Started, 'Service was not started');
    end;

    [Test]
    procedure CompletePrepareForArrival()
    begin
        // [SCENARIO 011] Staff completes an active Prepare for Arrival
        // [GIVEN] a room that is Final Cleaned and is marked “Work in Progress”
        CreateRoomWorkInProgress(Room);

        // [GIVEN] for this room, a service request of type “Prepare for Arrival” that is Started
        CreateStartedExistingRequest(Room, enum::"Service Request Type"::Prepare);

        // [WHEN] the housekeeping staff selects “Completed” for the request
        HouseKeeping.CompleteService(Room);

        // [THEN] the room gets status “Prepared”
        LibraryAssert.AreEqual(Enum::"Room Status"::Prepared, Room.Status, 'Unexpected Room Status');
        // [THEN] the service request is deleted
        LibraryAssert.IsFalse(ServiceRequestExists(Room), 'There should be no Service Request remaining');

    end;

    [Test]
    procedure StartFinalCleaningAndPrepareForArrival()
    begin
        // [SCENARIO 012] Staff starts working on Final Cleaning and Prepare for Arrival
        // [GIVEN] a room that is not cleaned
        CreateRoomNotCleaned(Room);
        // [GIVEN] for this room, a service request of type “Final Cleaning and Prepare for Arrival” that is not Started
        CreateExistingRequest(Room, enum::"Service Request Type"::FinalAndPrepare);

        // [WHEN] the housekeeping staff selects “Start Service” for the request
        HouseKeeping.StartService(Room);

        // [THEN] the room gets status “Work In Progress”
        LibraryAssert.AreEqual(enum::"Room Status"::WorkInProgress, Room.Status, 'Room Status is not updated');
        // [THEN] the service request gets status “Started”
        ServiceRequest := GetServiceRequest(Room);
        LibraryAssert.IsTrue(ServiceRequest.Started, 'Service was not started');
    end;

    [Test]
    procedure CopmpleteFinalCleaningAndPrepareForArrival()
    begin
        // [SCENARIO 013] Staff completes an active Final Cleaning and Prepare for Arrival
        // [GIVEN] a room that is not cleaned and is marked “Work in Progress”
        CreateRoomWorkInProgress(Room);

        // [GIVEN] for this room, a service request of type “Final Cleaning and Prepare for Arrival” that is Started
        CreateStartedExistingRequest(Room, enum::"Service Request Type"::FinalAndPrepare);

        // [WHEN] the housekeeping staff selects “Completed” for the request
        HouseKeeping.CompleteService(Room);

        // [THEN] the room gets status “Prepared”
        LibraryAssert.AreEqual(Enum::"Room Status"::Prepared, Room.Status, 'Unexpected Room Status');
        // [THEN] the service request is deleted
        LibraryAssert.IsFalse(ServiceRequestExists(Room), 'There should be no Service Request remaining');
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

    local procedure CreateRoomWorkInProgress(var Room: Record Room)
    begin
        CreateRoom(Room);
        Room.Status := Room.Status::WorkInProgress;
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

    local procedure CreateStartedExistingRequest(Room: Record Room; ServiceRequestType: enum "Service Request Type")
    var
        ServiceRequest: Record "Service Request";
    begin
        if ServiceRequestType <> ServiceRequestType::None then begin
            ServiceRequest.Init();
            ServiceRequest.RoomNo := Room."No.";
            ServiceRequest.ServiceRequestType := ServiceRequestType; //do not validate here
            ServiceRequest.Started := true;
            ServiceRequest.Insert();
        end;
    end;

    local procedure DeleteRequestsForRoom(Room: Record Room)
    begin
        Room.Request(enum::"Service Request Type"::None);
    end;

    local procedure HousekeepingPlannerSelectsFinalCleaning(Room: Record Room)
    begin
        // HousekeepingPlannerTestPage.OpenView();
        // HousekeepingPlannerTestPage.GoToRecord(Room);
        // HousekeepingPlannerTestPage.FinalCleaning.Invoke();
        // HousekeepingPlannerTestPage.Close();
        Room.Request(enum::"Service Request Type"::Final);
    end;

    local procedure HousekeepingPlannerSelectsPrepareForArrival(Room: Record Room)
    begin
        // HousekeepingPlannerTestPage.OpenView();
        // HousekeepingPlannerTestPage.GoToRecord(Room);
        // HousekeepingPlannerTestPage.PrepareForArrival.Invoke();
        // HousekeepingPlannerTestPage.Close();
        Room.Request(enum::"Service Request Type"::Prepare);
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