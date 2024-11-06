pageextension 50046 AfkPostedPurchInvoiceSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Afk_Quantity1"; Rec.Afk_Quantity1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Quantity2"; Rec.Afk_Quantity2)
            {
                ApplicationArea = Suite;
            }
        }
    }
}