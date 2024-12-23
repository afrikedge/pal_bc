page 50012 AfkPostedItemReqSubform
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    LinksAllowed = false;
    //MultipleNewLines = true;
    SourceTableView = WHERE("Document Type" = FILTER(ItemReq));
    SourceTable = AfkPostDocRequisitionLine;

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
                    //ShowMandatory = true;

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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    //ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    //Visible = DimVisible1;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Price"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Amount"; Rec.Amount)
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                field("Purchase Account"; Rec."Purchase Account")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Whse Quantity To Deliver"; Rec."Whse Quantity To Deliver")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Whse Delivered Quantity"; Rec."Whse Delivered Quantity")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }



            }
        }
    }
}
