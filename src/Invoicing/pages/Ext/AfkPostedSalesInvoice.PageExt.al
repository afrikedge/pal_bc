pageextension 50037 AfkPostedSalesInvoice extends "Posted Sales Invoice"
{
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
