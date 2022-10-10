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

        addafter("Job Task No.")
        {
            field("Afk_PurchaseAccount"; Rec.Afk_PurchaseAccount)
            {
                ApplicationArea = Basic;
            }
        }
    }
}
