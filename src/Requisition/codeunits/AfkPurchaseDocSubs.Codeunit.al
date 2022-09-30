codeunit 50008 AfkPurchaseDocEventsSubs
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeSetDefaultType', '', true, false)]
    local procedure OnBeforeSetDefaultTypeOrder(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.InitPurchLineType(PurchaseLine, xPurchaseLine, IsHandled);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote Subform", 'OnBeforeSetDefaultType', '', true, false)]
    local procedure OnBeforeSetDefaultTypeQuote(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.InitPurchLineType(PurchaseLine, xPurchaseLine, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', true, false)]
    local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnBeforeReleasePurchaseDoc(PurchaseHeader, PreviewMode);
    end;


}
