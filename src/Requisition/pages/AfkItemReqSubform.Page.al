page 50007 "AfkItemRequisitionSubform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    LinksAllowed = false;
    MultipleNewLines = true;
    SourceTableView = WHERE("Document Type" = FILTER(ItemReq));
    SourceTable = AfkDocRequisitionLine;

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
                    Editable = CanEdit;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Editable = CanEdit;
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
                    Editable = CanEdit;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CanEdit;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CanEdit;
                }

                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Whse Quantity To Deliver"; Rec."Whse Quantity To Deliver")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Whse Delivered Quantity"; Rec."Whse Delivered Quantity")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
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
    var
        Header: Record AfkDocRequisition;
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Header := Rec.GetPurchHeader();
        CanEdit := Header.Status = Header.Status::Open;
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
        CanEdit := true;
        SetDimensionsVisibility();
    end;



    var
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        DimMgt: Codeunit DimensionManagement;
        Navigate: Page Navigate;
        CanEdit: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Text000: Label 'Assign No. ?';
        Text001: Label 'There is no line to modify.';
        Text002: Label 'A posted line cannot be modified.';
        Text003: Label 'You cannot assign numbers to a posted header.';


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

