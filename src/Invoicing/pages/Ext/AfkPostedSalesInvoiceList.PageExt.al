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
    actions
    {
        addafter("Update Document")
        {
            action(AfkSetDueDate)
            {
                ApplicationArea = All;
                Caption = 'Update the Deposit Date';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = DueDate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    SalesFilter: Record "Sales Invoice Header";
                begin
                    SalesFilter.SetRange("No.", Rec."No.");
                    REPORT.Run(REPORT::AfkSetSalesInvoiceDueDate, true, false, SalesFilter);
                end;
            }
        }
    }
}
