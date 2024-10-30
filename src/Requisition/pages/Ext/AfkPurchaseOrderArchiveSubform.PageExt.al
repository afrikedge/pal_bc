pageextension 50045 AfkPurchaseOrderArchiveSubform extends "Purchase Order Archive Subform"
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
