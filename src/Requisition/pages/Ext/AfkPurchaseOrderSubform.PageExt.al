pageextension 50018 AfkPurchaseOrderSubform extends "Purchase Order Subform"
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
