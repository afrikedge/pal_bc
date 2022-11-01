page 50016 AfkWhseDeliveryCard
{
    Caption = 'Delivery Card';
    SourceTable = AfkWhseDelivery;
    PageType = Document;
    SourceTableView = WHERE("Document Type" = FILTER("ItemReq"));
    UsageCategory = Documents;
    Editable = false;
    //PromotedActionCategories = 'New,Process,Report,Approbation,Release,Request Approval';

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
                    //ToolTip = 'Specifies the number of the Item requisition.';
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
                // field("Status"; Rec.Status)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Document Date"; Rec."Document Date")
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
                // field("Delivery Status"; Rec."Delivery Status")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

            }
            part(Lines; "AfkWhseDeliverySubform")
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
            action("Ledger E&ntries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Ledger E&ntries';
                Image = ItemLedger;
                RunObject = Page "Item Ledger Entries";
                RunPageLink = "Document No." = FIELD("No.");
                RunPageView = SORTING("Item No.")
                                      ORDER(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected document.';
            }
            action(AfkPrintPreview)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    DeliveryH: Record "AfkWhseDelivery";
                    AfkBudgetTracking: Report AfkWhseDelivery;
                begin
                    DeliveryH.SetRange("No.", Rec."No.");
                    AfkBudgetTracking.SetTableView(DeliveryH);
                    AfkBudgetTracking.Run();
                    //REPORT.Run(REPORT::AfkBudgetTracking, true, false, BudgetLine);
                end;
            }
        }
    }
}
