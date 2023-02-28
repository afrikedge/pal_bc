pageextension 50033 AfkPostedSalesInvoiceList extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Remaining Amount")
        {
            field("Afk_ResponsibilityCenter"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Afk_ExternalDocumentNo"; Rec."External Document No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
