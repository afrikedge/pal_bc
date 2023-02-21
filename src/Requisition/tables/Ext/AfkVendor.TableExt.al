tableextension 50015 AfkVendor extends Vendor
{
    fields
    {
        field(50000; Afk_TSR_Pourcent; Decimal)
        {
            Caption = 'TSR %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group".Afk_TSR_Pourcent where(Code = field("Vendor Posting Group")));
        }
        field(50001; Afk_IR_Pourcent; Decimal)
        {
            Caption = 'IR %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group".Afk_IR_Pourcent where(Code = field("Vendor Posting Group")));
        }
        field(50002; Afk_TradeRegister; Code[30])
        {
            //Registre de commerce
            Caption = 'Trade Register';
            DataClassification = CustomerContent;
        }
        field(50003; "Afk_Tax_Number"; Code[30])
        {
            //Numéro contribuable
            Caption = 'Tax Number';
            DataClassification = CustomerContent;
        }
    }
}
