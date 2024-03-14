codeunit 50100 "Installation"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InsertDefaultChickenTypes();
    end;

    local procedure InsertDefaultChickenTypes()
    var
        ChickenType: Record "Chicken Type";
    begin
        Clear(ChickenType);
        if ChickenType.IsEmpty() then begin
            InsertChickenType('CHICKEN01', 'Brown Chicken');
            InsertChickenType('CHICKEN02', 'White Chicken');
            InsertChickenType('CHICKEN03', 'Black Chicken');
        end;
    end;

    local procedure InsertChickenType(ChickenTypeCode: Code[20]; ChickenTypeDescription: Text[50])
    var
        ChickenType: Record "Chicken Type";
    begin
        Clear(ChickenType);
        ChickenType.Code := ChickenTypeCode;
        ChickenType.Description := ChickenTypeDescription;
        ChickenType.Insert();
    end;
}