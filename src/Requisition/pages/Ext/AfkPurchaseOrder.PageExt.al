pageextension 50016 AfkPurchaseOrder extends "Purchase Order"
{
    Caption = 'Purchase Commitment';

    layout
    {
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Offer Ref.';
            ShowMandatory = true;
        }
        addafter("Vendor Order No.")
        {
            field("Afk_CommitmentType"; Rec.Afk_CommitmentType)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_ValidityStartingDate"; Rec.Afk_ValidityStartingDate)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_Validity"; Rec.Afk_Validity)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_ValidityEndingDate"; Rec.Afk_ValidityEndingDate)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_VendorNotified"; Rec.Afk_VendorNotified)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_NotificationDate"; Rec.Afk_NotificationDate)
            {
                ApplicationArea = Basic, Suite;
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
                    AfkPurchaseReqMgt.SolderCdeAchat(Rec);
                end;
            }
        }
    }
    var
        AfkBudgetControl: Codeunit AfkBudgetControl;
        AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;
}
