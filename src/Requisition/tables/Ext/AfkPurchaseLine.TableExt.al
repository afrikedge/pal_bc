tableextension 50006 AfkPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; Afk_PurchaseAccount; Code[20])
        {
            Caption = 'Purchase Account';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_PurchReqLineNo"; Integer)
        {
            Caption = 'Purchase Req line';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; Afk_PurchReqNo; Code[20])
        {
            Caption = 'Purchase Req Doc';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50003; "Afk_Quantity1"; Decimal)
        {
            Caption = 'Number of Days';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateAmounts();
            end;
        }
        field(50004; "Afk_Quantity2"; Decimal)
        {
            Caption = 'Number of Participants';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateAmounts();
            end;
        }
    }
    keys
    {
        key("Afk_PurchaseAccount"; "Afk_PurchaseAccount")
        {

        }
    }
    local procedure UpdateAmounts()
    var
    begin
        Validate(Quantity, Afk_Quantity1 * Afk_Quantity2);
        Validate("Direct Unit Cost");
    end;
}