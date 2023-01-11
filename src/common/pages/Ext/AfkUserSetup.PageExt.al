pageextension 50010 AfkUserSetup extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("AfkCanValidateBudgetTransfer"; Rec."Afk_CanValidateBudgetTransfer")
            {
                ApplicationArea = Suite;
            }
            field("Afk_CanValidateBudgetRevision"; Rec.Afk_CanValidateBudgetRevision)
            {
                ApplicationArea = Suite;
            }

            field("Afk_CanUpdateNotificationInfos"; Rec.Afk_CanUpdateNotificationInfos)
            {
                ApplicationArea = Suite;
            }
            field("Afk_CanSkipBudgetControl"; Rec.Afk_CanSkipBudgetControl)
            {
                ApplicationArea = Suite;
            }
            field("Afk_DefaultTask"; Rec.Afk_DefaultTask)
            {
                ApplicationArea = Suite;
            }
            field("Afk_DefaultNature"; Rec.Afk_DefaultNature)
            {
                ApplicationArea = Suite;
            }

            field("Afk_PRAmountApprovalLimit"; Rec.Afk_PRAmountApprovalLimit)
            {
                ApplicationArea = Suite;
            }
            field("Afk_UnlimitedPRApproval"; Rec.Afk_UnlimitedPRApproval)
            {
                ApplicationArea = Suite;
            }
            field("Afk_CanUpdateAutoriseOnPayment"; Rec.Afk_CanUpdateAutoriseOnPayment)
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