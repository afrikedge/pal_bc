page 50014 AfkWhseDeliveryList
{
    Caption = 'Delivery List';
    SourceTable = AfkWhseDelivery;
    ApplicationArea = All;
    CardPageId = "AfkWhseDeliveryCard";
    PageType = List;
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SystemCreatedAt; rec.SystemCreatedAt)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Budget Code"; rec."Budget Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Amount Including VAT"; rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }


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
        }
    }
}
