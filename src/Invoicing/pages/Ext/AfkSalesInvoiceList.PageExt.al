pageextension 50034 AfkSalesInvoiceList extends "Sales Invoice List"
{
    layout
    {
        addafter("External Document No.")
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
