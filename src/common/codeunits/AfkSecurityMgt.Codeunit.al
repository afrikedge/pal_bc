codeunit 50011 AfkSecurityMgt
{
    procedure CheckCanModifyNotificationDate()
    var
        myInt: Integer;
    begin
        UserSetup.get(UserId);
        if (not UserSetup.Afk_CanUpdateNotificationInfos) then
            Error(CannotUpdateNotificationDateErr);
    end;

    var
        UserSetup: Record "User Setup";
        CannotUpdateNotificationDateErr: Label 'You are not authorised to update this notification Date';
}
