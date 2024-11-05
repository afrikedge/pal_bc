tableextension 50025 AfkPurchaseInvLine extends "Purch. Inv. Line"
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