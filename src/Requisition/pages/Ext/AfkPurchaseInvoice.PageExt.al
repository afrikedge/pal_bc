pageextension 50025 AfkPurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        moveafter("Vendor Order No."; "Shortcut Dimension 2 Code")
        moveafter("Vendor Order No."; "Shortcut Dimension 1 Code")
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
            }
        }
    }
    actions
    {
        addafter(CopyDocument)
        {
            action(AfkPrintAprioriBudgetCommitment)
            {
                ApplicationArea = All;
                Caption = 'A priori control of commitments';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    PurchaseHeader1: Record "Purchase Header";
                    BudgetControlOnDoc: Report AfkBudgetControlOnDoc;
                begin
                    PurchaseHeader1.Reset();
                    PurchaseHeader1.SetRange("Document Type", Rec."Document Type");
                    PurchaseHeader1.SetRange(PurchaseHeader1."No.", Rec."No.");
                    BudgetControlOnDoc.SetTableView(PurchaseHeader1);
                    BudgetControlOnDoc.Run();
                end;
            }
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

        }
    }
    var
        AfkBudgetControl: Codeunit AfkBudgetControl;
        AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;
}
