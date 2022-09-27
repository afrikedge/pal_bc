page 50007 "Purchase Requisition Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = AfkPostPurchaseRequisitionLine;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type"; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount"; Rec.)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Quantity (Base)"; Rec.VA)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Quantity (Base)"; Rec."Quantity (Base)")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Quantity (Base)"; Rec."Quantity (Base)")
                // {
                //     ApplicationArea = Basic, Suite;
                // }





                field("Document No."; Rec."Item Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the payment line.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or change the dimension settings for this payment slip. If you change the dimension, you can update all lines on the payment slip.';

                    trigger OnAction()
                    begin
                        //ShowDimensions();
                    end;
                }

                // action(Insert)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Insert';

                //     trigger OnAction()
                //     begin
                //         OnInsert;
                //     end;
                // }

                group("A&ccount")
                {

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //ActivateControls;
    end;

    trigger OnInit()
    begin
        // BankAccountCodeVisible := true;
        // CreditAmountVisible := true;
        // DebitAmountVisible := true;
        // AmountVisible := true;
        // AcceptationCodeVisible := true;
        // RIBVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //SetUpNewLine(xRec, BelowxRec);
    end;

    var
        Text000: Label 'Assign No. ?';
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        Text001: Label 'There is no line to modify.';
        Text002: Label 'A posted line cannot be modified.';
        Text003: Label 'You cannot assign numbers to a posted header.';
        Navigate: Page Navigate;
        [InDataSet]
        AccountNoEmphasize: Boolean;
        [InDataSet]
        AcceptationCodeVisible: Boolean;
        [InDataSet]
        AmountVisible: Boolean;
        [InDataSet]
        BankAccountCodeVisible: Boolean;
        [InDataSet]
        BankInfoEditable: Boolean;
        [InDataSet]
        CreditAmountVisible: Boolean;
        [InDataSet]
        DebitAmountVisible: Boolean;
        [InDataSet]
        RIBVisible: Boolean;



}

