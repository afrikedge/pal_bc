pageextension 50016 AfkPurchaseOrder extends "Purchase Order"
{
    Caption = 'Purchase Commitment';

    layout
    {
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Offer Ref.';
            //ShowMandatory = true;
        }
        modify("Quote No.")
        {
            Caption = 'Purchase Req No.';
        }

        moveafter("Vendor Order No."; "Shortcut Dimension 2 Code")
        moveafter("Vendor Order No."; "Shortcut Dimension 1 Code")

        modify("Vendor Shipment No.")
        {
            Visible = false;
        }

        addafter("Vendor Order No.")
        {
            field(Afk_IssuerCode; Rec.Afk_IssuerCode)
            {
                ApplicationArea = Basic, Suite;
            }
            field(Afk_Object; Rec.Afk_Object)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
            }
            field("Afk_CommitmentType"; Rec.Afk_CommitmentType)
            {
                ApplicationArea = Basic, Suite;
                trigger OnValidate()
                begin
                    Rec.TestField("Quote No.", '');
                    if (Rec.Afk_CommitmentType = Rec.Afk_CommitmentType::"Purchase order") then
                        Error(Text001);

                    DocIsEditable := (Rec.Afk_CommitmentType <> Rec.Afk_CommitmentType::"Purchase order");
                    //CurrPage.PurchLines.Page.;(true);
                end;
            }
            // field("Afk_ValidityStartingDate"; Rec.Afk_ValidityStartingDate)
            // {
            //     ApplicationArea = Basic, Suite;
            // }
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
            field("Afk_TSR_Pourcent"; Rec.Afk_TSR_Pourcent)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Afk_IR_Pourcent"; Rec.Afk_IR_Pourcent)
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


        modify("Buy-from Vendor No.")
        {
            Editable = DocIsEditable;
        }
        modify("Buy-from Vendor Name")
        {
            Editable = DocIsEditable;
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
    trigger OnOpenPage()
    var
    //isRelease: Boolean;
    begin
        //isRelease := Rec.Status = Rec.Status::Released;
        DocIsEditable := (Rec.Afk_CommitmentType <> Rec.Afk_CommitmentType::"Purchase order");
    end;

    trigger OnAfterGetRecord()
    var
    begin
        DocIsEditable := (Rec.Afk_CommitmentType <> Rec.Afk_CommitmentType::"Purchase order");
    end;

    var
        AfkBudgetControl: Codeunit AfkBudgetControl;
        AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;
        DocIsEditable: Boolean;
        Text001: Label 'You cannot create this type of commitment directly';
}
