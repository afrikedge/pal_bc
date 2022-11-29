pageextension 50017 AfkPurchaseOrderList extends "Purchase Order List"
{
    Caption = 'Purchase Commitments';

    layout
    {
        addlast(Control1)
        {
            field("AfkQuote No."; Rec."Quote No.")
            {
                Caption = 'Purchase Req No.';
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
