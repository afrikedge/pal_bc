tableextension 50014 AfkVendorPostingGroup extends "Vendor Posting Group"
{
    fields
    {
        field(50000; Afk_TSR_Pourcent; Decimal)
        {
            Caption = 'TSR %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50001; Afk_IR_Pourcent; Decimal)
        {
            Caption = 'IR %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50002; Afk_TSR_Account; Code[20])
        {
            Caption = 'TSR Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50003; Afk_IR_Account; Code[20])
        {
            Caption = 'IR Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50004; Afk_VAT_Deduction; Boolean)
        {
            Caption = 'Withhold VAT';
            DataClassification = CustomerContent;
        }
        field(50005; Afk_VATWithholding_Account; Code[20])
        {
            Caption = 'VAT Withholding Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }
}
