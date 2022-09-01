codeunit 50003 AfkEventsSubs
{
    SingleInstance = true;

    // [IntegrationEvent(TRUE, false)]
    // local procedure OnAfterNoOnAfterValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemValues', '', false, false)]
    // local procedure UpdateSalesLineFromItem(var SalesLine: Record "Sales Line"; Item: Record Item)
    // var
    //     AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    // begin
    //     AfkPricingMgt.SetSalesLineDefValues(SalesLine, SalesLine.GetSalesHeader());
    // end;

    [EventSubscriber(ObjectType::Page, Page::"Sales invoice Subform", 'OnAfterNoOnAfterValidate', '', true, false)]
    local procedure UpdateSalesLineFromItem(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.SetSalesLineDefValues(SalesLine, SalesLine.GetSalesHeader());
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitInsert', '', true, false)]
    local procedure UpdateSalesInvoiceNosSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.LoadSalesInvoiceNosSeries(SalesHeader, xSalesHeader, IsHandled);
    end;
}