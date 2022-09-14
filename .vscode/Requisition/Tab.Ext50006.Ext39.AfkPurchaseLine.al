tableextension 50006 AfkPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; Afk_PurchaseAccount; Code[20])
        {
            Caption = 'Purchase Account';
            Editable = false;
        }
        field(50001; "Afk_PurchReqLineNo"; Integer)
        {
            Caption = 'Purchase Req line';
            Editable = false;
        }
        field(50002; Afk_PurchReqNo; Code[20])
        {
            Caption = 'Purchase Req Doc';
            Editable = false;
        }
    }

}