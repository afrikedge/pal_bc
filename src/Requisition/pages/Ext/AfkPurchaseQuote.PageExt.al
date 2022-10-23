pageextension 50014 AfkPurchaseQuote extends "Purchase Quote"
{
    Caption = 'Purchase Request';
    layout
    {
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Offer Ref.';
            ShowMandatory = true;
        }
        addafter("Vendor Order No.")
        {
            field(Afk_Object; Rec.Afk_Object)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
            }
        }
        addafter(PurchLines)
        {
            part(AfkBudgetLines; AfkBudgetLinesSubForm)
            {
                Caption = 'Budget summary';
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                //UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        addafter(CopyDocument)
        {
            action(AfkCalculateBudget)
            {
                ApplicationArea = Suite;
                Caption = 'Calculate Budget';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                trigger OnAction()
                begin
                    AfkBudgetControl.CreatePurchaseBudgetLines(Rec, false);
                end;
            }
            action(AfkCloseDocument)
            {
                ApplicationArea = Suite;
                Caption = 'Close Document';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                trigger OnAction()
                begin
                    AfkPurchaseReqMgt.SolderDemandeAchat(Rec);
                end;
            }
            action(AfkPrintFollowUp)
            {
                ApplicationArea = All;
                Caption = 'Print Preview';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    SalesFilter: Record "Sales Header";
                begin
                    SalesFilter.SetRange("No.", Rec."No.");
                    REPORT.Run(REPORT::AfkSalesInvoicePreview, true, false, SalesFilter);
                end;
            }
        }
    }
    var
        AfkBudgetControl: Codeunit AfkBudgetControl;
        AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;

}
