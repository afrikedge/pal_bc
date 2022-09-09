pageextension 50007 AfkRespCenterList extends "Responsibility Center List"
{
    layout
    {
        addafter("Location Code")
        {
            field(AfkSalesInvoiceNos; Rec.AfkSalesInvoiceNos)
            {
                ToolTip = 'Sales Invoice Numbers';
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}