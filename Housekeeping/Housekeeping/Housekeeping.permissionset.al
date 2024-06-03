permissionset 50200 "Housekeeping Planner"
{
    Assignable = true;
    Caption = 'Housekeeping Planner';
    Permissions =
        tabledata Room = RIMD,
        tabledata "Service Request" = RIMD,
        table Room = X,
        table "Service Request" = X,
        codeunit Housekeeping = X,
        page "Housekeeping Planner" = X;
}