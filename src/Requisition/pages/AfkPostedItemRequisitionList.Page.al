page 50011 AfkPostedItemRequisitionList
{
    ApplicationArea = All;
    Caption = 'PostedItemRequisitionList';
    CardPageId = "AfkPostedItemRequisition";
    PageType = List;
    SourceTable = AfkPostedDocRequisition;
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
                field("Amount Including VAT"; rec."Amount Including VAT")
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
}
