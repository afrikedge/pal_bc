pageextension 50005 AfkCustomerCard extends "Customer Card"
{
    layout
    {
        addfirst("Invoicing")
        {
            field("Afk_Tax_Number"; Rec.Afk_Tax_Number)
            {
                ToolTip = 'Taxpayer Number';
                ApplicationArea = Suite;
            }
            field("Afk_TradeRegister"; Rec.Afk_TradeRegister)
            {
                ToolTip = 'Trade Register Number';
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}