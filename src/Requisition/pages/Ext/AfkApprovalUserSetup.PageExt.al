pageextension 50009 AfkApprovalUserSetup extends "Approval User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("PR Amount Approval Limit"; Rec."AfkPRAmountApprovalLimit")
            {
                ApplicationArea = Suite;
            }
            field("Unlimited PR Approval"; Rec."AfkUnlimitedPRApproval")
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