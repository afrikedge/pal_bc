tableextension 50024 AfkPurchaseLineArchive extends "Purchase Line Archive"
{
    fields
    {
        field(50003; "Afk_Quantity1"; Decimal)
        {
            Caption = 'Number of Days';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50004; "Afk_Quantity2"; Decimal)
        {
            Caption = 'Number of Participants';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
    }
}