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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}