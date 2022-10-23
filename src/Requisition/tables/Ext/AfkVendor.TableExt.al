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
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group".Afk_IR_Pourcent where(Code = field("Vendor Posting Group")));
        }
        field(50001; Afk_IR_Pourcent; Decimal)
        {
            Caption = 'IR %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group".Afk_IR_Pourcent where(Code = field("Vendor Posting Group")));
        }
    }
}
