pageextension 50009 AfkApprovalUserSetup extends "Approval User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Afk_PRAmountApprovalLimit"; Rec."Afk_PRAmountApprovalLimit")
            {
                ApplicationArea = Suite;
            }
            field("Afk_UnlimitedPRApproval"; Rec."Afk_UnlimitedPRApproval")
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