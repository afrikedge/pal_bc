page 50006 "Purchase Requisition"
{
    Caption = 'Purchase Requisition';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = AfkPurchaseRequisition;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    ToolTip = 'Specifies the number of the purchase requisition.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Lookup = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Editable = false;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("External Doc No"; Rec."External Doc No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            part(Lines; "Payment Slip Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }

        }
        area(factboxes)
        {
            // part("Payment Journal Errors"; "Payment Journal Errors Part")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'File Export Errors';
            //     Provider = Lines;
            //     SubPageLink = "Document No." = FIELD("No."),
            //                   "Journal Line No." = FIELD("Line No."),
            //                   "Journal Template Name" = CONST(''),
            //                   "Journal Batch Name" = CONST('10865');
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Header")
            {
                Caption = '&Header';
                Image = DepositSlip;
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ToolTip = 'View or change the dimension settings for this payment slip. If you change the dimension, you can update all lines on the payment slip.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                // action("Header RIB")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Header RIB';
                //     Image = Check;
                //     RunObject = Page "Payment Bank";
                //     RunPageLink = "No." = FIELD("No.");
                //     ToolTip = 'View the RIB key that is associated with the bank account.';
                // }
            }

        }
        area(processing)
        {

        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Lines.PAGE.Editable(true);
    end;

    var
        PaymentStep: Record "Payment Step";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Navigate: Page Navigate;
        Text001: Label 'This payment class does not authorize vendor suggestions.';
        Text002: Label 'This payment class does not authorize customer suggestions.';
        Text003: Label 'You cannot suggest payments on a posted header.';
        Text009: Label 'Do you want to archive this document?';

    local procedure DocumentDateOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;
}

