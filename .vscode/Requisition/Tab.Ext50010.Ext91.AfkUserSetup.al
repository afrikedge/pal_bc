tableextension 50010 AfkUserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Afk_PRType"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
        }
        field(50001; "Afk_POType"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
        }
    }

}