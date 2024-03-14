codeunit 50101 Upgrade
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        ModuleInfo: ModuleInfo;
    begin
        if NavApp.GetCurrentModuleInfo(ModuleInfo) then
            if ModuleInfo.AppVersion.Major() = 1 then ChangeChickenTypes;
    end;

    local procedure ChangeChickenTypes()
    begin
        ChangeChickenType('ChickenType01', 'Type 01', 'Type 01');
        ChangeChickenType('ChickenType02', 'Type 02', 'Type 02');
        ChangeChickenType('ChickenType03', 'Type 03', 'Type 03');
    end;

    local procedure ChangeChickenType(OldCode: Code[20]; NewCode: Code[20]; NewDescription: Text[100])
    var
        ChickenType: Record "Chicken Type";
    begin
        Clear(ChickenType);
        ChickenType.SetFilter(Code, OldCode);
        if ChickenType.FindFirst() then begin
            ChickenType.Rename(NewCode);
            ChickenType.Description := NewDescription;
            ChickenType.Modify();
        end;
    end;
}