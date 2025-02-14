pageextension 50019 AfkPurchaseQuoteSubform extends "Purchase Quote Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = false;
            Editable = false;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
            Editable = false;
        }

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

        // addafter("Job Task No.")
        // {
        //     field("Afk_PurchaseAccount"; Rec.Afk_PurchaseAccount)
        //     {
        //         ApplicationArea = Basic;
        //     }
        // }
    }
}
