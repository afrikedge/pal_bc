codeunit 50010 AfkBudgetControlEventsSubs
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        AfkBudgetControlMgt.CreatePurchaseBudgetLines(PurchaseHeader, true);
    end;











    var
        AfkBudgetControlMgt: Codeunit AfkBudgetControl;


}