codeunit 50010 AfkBudgetControlEventsSubs
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeShowPurchApprovalStatus', '', false, false)]
    local procedure OnBeforeShowPurchApprovalStatus(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        AfkBudgetControlMgt.CreatePurchaseBudgetLines(PurchaseHeader, true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        AfkPurchMgt.OnBeforeSendPurchaseDocForApproval(PurchaseHeader);
    end;






    var
        AfkBudgetControlMgt: Codeunit AfkBudgetControl;
        AfkPurchMgt: Codeunit AfkPurchaseReqMgt;


}