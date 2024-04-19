codeunit 50100 "Vendor Password Management"
{
    procedure HandlePaswordAction(KeyId: Code[20]; WebshopPasswordStateProp: Enum "Vendor Password State")
    begin
        if WebshopPasswordStateProp = "Vendor Password State"::Available then
            HandlePasswordChange(KeyId)
        else if WebshopPasswordStateProp = "Vendor Password State"::Assign then
            HandlePasswordSet(KeyId);
    end;

    local procedure HandlePasswordSet(KeyId: Code[20])
    var
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        PasswordSetSuccessLbl: Label 'Password set successfully!';
        NewPassword: Text;
    begin
        NewPassword := PasswordDialogManagement.OpenPasswordDialog();
        if NewPassword <> '' then
            ChangePassword(KeyId, NewPassword, PasswordSetSuccessLbl);
    end;

    local procedure HandlePasswordChange(KeyId: Code[20])
    var
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        PasswordChangeSuccessLbl: Label 'Password changed successfully!';
        OldPassword: Text;
        OldPasswordInput: Text;
        NewPasswordInput: Text;
        ErrorChangingPasswordLbl: Label 'Invalid input';
        ErrorChangingPasswordMsg: Label 'Old password is incorect';
        PasswordChangeErrorInfo: ErrorInfo;
    begin
        if not IsolatedStorage.Get(KeyId, OldPassword) then exit;

        PasswordDialogManagement.OpenChangePasswordDialog(OldPasswordInput, NewPasswordInput);

        if NewPasswordInput = '' then exit;

        if OldPassword = OldPasswordInput then
            ChangePassword(KeyId, NewPasswordInput, PasswordChangeSuccessLbl)
        else begin
            PasswordChangeErrorInfo.Title := ErrorChangingPasswordLbl;
            PasswordChangeErrorInfo.Message := ErrorChangingPasswordMsg;
            Error(PasswordChangeErrorInfo);
        end;
    end;

    local procedure ChangePassword(KeyId: Code[20]; NewPassword: Text; SuccessLbl: Text)
    begin
        if IsolatedStorage.Set(KeyId, NewPassword) then
            Message(SuccessLbl);
    end;

    procedure GetPasswordState(KeyId: Code[20]) WebshopPasswordState: Enum "Vendor Password State"
    var
        HasWebshopPassword: Boolean;
    begin
        HasWebshopPassword := IsolatedStorage.Contains(KeyId);
        if HasWebshopPassword then
            WebshopPasswordState := "Vendor Password State"::Available
        else
            WebshopPasswordState := "Vendor Password State"::Assign;
    end;

    procedure DeletePassword(KeyId: Code[20])
    var
        PasswordDeletedLbl: Label 'Password deleted successfully!';
    begin
        if IsolatedStorage.Delete(KeyId) then
            Message(PasswordDeletedLbl);
    end;

    procedure ShowPassword(KeyId: Code[20])
    var
        Password: Text;
    begin
        if IsolatedStorage.Get(KeyId, Password) then
            Message(Password);
    end;
}