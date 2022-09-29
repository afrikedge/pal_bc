page 50007 "AfkPurchaseRequisitionSubform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    LinksAllowed = false;
    MultipleNewLines = true;
    SourceTableView = WHERE("Document Type" = FILTER(Requisition));
    SourceTable = AfkPurchaseRequisitionLine;

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
                    //Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        //NoOnAfterValidate();

                        //UpdateTypeText();
                        //DeltaUpdateTotals();

                        CurrPage.Update();
                    end;
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
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Purchase Account"; Rec."Purchase Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    //ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    //ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible2;
                }
                // field(ShortcutDimCode3; ShortcutDimCode[3])
                // {
                //     ApplicationArea = Dimensions;
                //     CaptionClass = '1,2,3';
                //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                //                                                   "Dimension Value Type" = CONST(Standard),
                //                                                   Blocked = CONST(false));
                //     Visible = DimVisible3;

                //     trigger OnValidate()
                //     begin
                //         Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);

                //         //OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 3);
                //     end;
                // }



                // field("Document No."; Rec."Item Reference")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies a document number for the payment line.';
                // }

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
                        Rec.ShowDimensions();
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
        Rec.ShowShortcutDimCode(ShortcutDimCode);
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

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     //SetUpNewLine(xRec, BelowxRec);
    // end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Clear(ShortcutDimCode);
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;



    var
        Text000: Label 'Assign No. ?';
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        Text001: Label 'There is no line to modify.';
        Text002: Label 'A posted line cannot be modified.';
        Text003: Label 'You cannot assign numbers to a posted header.';
        Navigate: Page Navigate;
        ShortcutDimCode: array[8] of Code[20];
        DimMgt: Codeunit DimensionManagement;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;


    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);

    end;

}

