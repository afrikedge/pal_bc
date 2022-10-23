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
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50003; Afk_IR_Account; Code[20])
        {
            Caption = 'IR Account';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }
}
