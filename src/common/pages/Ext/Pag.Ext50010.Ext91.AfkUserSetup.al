pageextension 50010 AfkUserSetup extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("AfkCanValidateBudgetTransfer"; Rec."AfkCanValidateBudgetTransfer")
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