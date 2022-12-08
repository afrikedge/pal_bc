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
        PurchMgt.OnBeforeReleasePurchaseDoc(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOnDelete', '', true, false)]
    local procedure OnBeforeOnDelete(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnBeforeOnDeletePurchaseDoc(PurchaseHeader, IsHandled);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', true, false)]
    local procedure OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnAfterInitPurchaseDoc(PurchHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnPrintRecordsOnAfterCheckMixedDropShipment', '', true, false)]
    local procedure OnPrintRecordsOnAfterCheckMixedDropShipment(var PurchaseHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnBeforePrintPurchaseDoc(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeConfirmDeletion', '', true, false)]
    local procedure OnBeforeConfirmDeletion(var PurchaseHeader: Record "Purchase Header"; var Result: Boolean; var IsHandled: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnBeforeConfirmDeletion(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignFieldsForNo', '', true, false)]
    local procedure OnAfterAssignFieldsForNo(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnAfterAssignFieldsForNo(PurchLine, xPurchLine, PurchHeader);
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', true, false)]
    local procedure OnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnBeforeDeletePurchQuote_CreateOrder(QuotePurchHeader, OrderPurchHeader, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforeInitRecord', '', true, false)]
    local procedure OnCreatePurchHeaderOnBeforeInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnCreatePurchHeaderOnBeforeInitRecord_CreateOrder(PurchOrderHeader, PurchHeader);
    end;




    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    // local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    // var
    //     AfkBudgetControlMgt: codeunit AfkBudgetControl;
    // begin
    //     // AfkBudgetControlMgt.CreatePurchaseBudgetLines(PurchaseHeader, true);
    //     AfkBudgetControlMgt.OnBeforeReleasePurchaseDoc(PurchaseHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnAfterInsertAllPurchOrderLines', '', true, false)]
    local procedure OnAfterInsertAllPurchOrderLines(var PurchOrderLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnAfterInsertAllPurchOrderLines(PurchOrderLine, PurchQuoteHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', true, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.OnAfterInsertVendorOnPurchase(PurchaseHeader, Vendor, xPurchaseHeader);
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckDirectUnitCost', '', true, false)]
    // local procedure OnBeforeCheckDirectUnitCost(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    // var
    //     PurchMgt: codeunit AfkPurchaseReqMgt;
    // begin
    //     PurchMgt.CheckBudgetOnLineUpdate(PurchaseLine);
    // end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterCalcLineAmount', '', true, false)]
    local procedure OnAfterCalcLineAmount(var PurchaseLine: Record "Purchase Line"; var LineAmount: Decimal)
    var
        PurchMgt: codeunit AfkPurchaseReqMgt;
    begin
        PurchMgt.CheckBudgetOnLineUpdate(PurchaseLine);
    end;











}
