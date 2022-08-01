codeunit 50003 AfkEventsSubs
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure UpdateSalesLineFromItem(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        AfkPricingMgt: codeunit AfkPortServiceInvMgt;
    begin
        AfkPricingMgt.SetSalesLineDefValues(SalesLine, SalesLine.GetSalesHeader());
    end;
}