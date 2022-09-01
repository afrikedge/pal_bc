pageextension 50006 AfkRespCenterCard extends "Responsibility Center Card"
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