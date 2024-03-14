permissionset 50100 ChickenManagement
{
    Assignable = true;
    Caption = 'ChickenManagement', MaxLength = 30;
    Permissions =
        table "Egg Production Line" = X,
        tabledata "Egg Production Line" = RMID,
        table Chicken = X,
        tabledata Chicken = RMID,
        table "Egg Production Header" = X,
        tabledata "Egg Production Header" = RMID,
        table EggType = X,
        tabledata EggType = RMID,
        table "Chicken Type" = X,
        tabledata "Chicken Type" = RMID,
        codeunit Installation = X,
        page "Egg Production Subpage" = X,
        page "Egg Production List" = X,
        page "Egg Production Line List" = X,
        page "Egg Production Document" = X,
        page "Chicken Types" = X,
        page "Chicken Management Rolecenter" = X,
        page "Chicken List" = X,
        page "Chicken Card" = X,
        page "Egg Types" = X;
}
