page 50008 "AfkPurchRequisitionList"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Purchase Requisition List';
    CardPageID = AfkPurchaseRequisition;
    Editable = false;
    PageType = List;
    SourceTable = AfkPurchaseRequisition;
    UsageCategory = Lists;

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
    }

    actions
    {
        area(creation)
        {
            /* action("Create Payment Slip")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Payment Slip';
                Image = NewDocument;
                RunObject = Codeunit "Payment Management";
                ToolTip = 'Manage information about customer and vendor payments.';
            } */
        }
    }
}

