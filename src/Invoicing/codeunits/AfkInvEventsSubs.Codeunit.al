codeunit 50003 AfkInvEventsSubs
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Page, Page::"Sales invoice Subform", 'OnAfterNoOnAfterValidate', '', true, false)]
    local procedure UpdateSalesLineFromItem(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.SetSalesLineDefValues(SalesLine, SalesLine.GetSalesHeader());
    end;


    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitInsert', '', true, false)]
    // local procedure UpdateSalesInvoiceNosSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // var
    //     AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    // begin
    //     AfkPricingMgt.LoadSalesInvoiceNosSeries(SalesHeader, xSalesHeader, IsHandled);
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitPostingNoSeries', '', true, false)]
    local procedure OnAfterInitPostingNoSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.LoadSalesInvoicePostingNosSeries(SalesHeader, xSalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Responsibility Center', true, false)]
    local procedure OnAfterValidateEventRespCenter(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.OnAfterValidate_RespCenter(Rec, xRec, CurrFieldNo);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice Subform", 'OnBeforeSetDefaultType', '', true, false)]
    local procedure OnBeforeSetDefaultType(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.InitSalesLineType(SalesLine, xSalesLine, IsHandled);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnBeforeApplyStdCodesToSalesLines', '', true, false)]
    local procedure OnBeforeApplyStdCodesToSalesLines(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.InitSalesLineFromStandartLine(SalesLine, StdSalesLine);
    end;



}