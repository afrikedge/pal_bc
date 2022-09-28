pageextension 50009 AfkApprovalUserSetup extends "Approval User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("PR Amount Approval Limit"; Rec."PR Amount Approval Limit")
            {
                ApplicationArea = Suite;
            }
            field("Unlimited PR Approval"; Rec."Unlimited PR Approval")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}