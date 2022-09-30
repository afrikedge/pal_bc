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
    }
}
