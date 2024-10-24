page 50013 AfkPostedItemRequisition
{
    Caption = 'Posted Item Requisition';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "AfkPostedDocRequisition";
    SourceTableView = WHERE("Document Type" = FILTER("ItemReq"));
    UsageCategory = Documents;
    Editable = false;

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
                    ToolTip = 'Specifies the number of the Item requisition.';
                    Editable = false;
                    Visible = false;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Lookup = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Editable = false;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
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
                    //ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Lines; AfkPostedItemReqSubform)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = FIELD("No.");
            }

        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("DeliveryForms")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delivery List';
                Image = ItemLedger;
                RunObject = Page "AfkWhseDeliveryList";
                RunPageLink = "External Doc No" = FIELD("No.");
                Promoted = true;
                PromotedCategory = Process;
                //RunPageView = SORTING("Item No.")
                //                      ORDER(Descending);
                ShortCutKey = 'Ctrl+F7';
                //ToolTip = 'View the history of transactions that have been posted for the selected document.';
            }
        }
    }
}
