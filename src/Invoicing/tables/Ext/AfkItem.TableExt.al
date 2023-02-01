tableextension 50002 AfkItem extends "Item"
{
    fields
    {
        field(50000; "Afk_Quantity1"; Code[30])
        {
            Caption = 'Base';
            TableRelation = "Afk_Calc_Parameter";
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_Unit_of_Measure_Code_1"; Code[10])
        {
            Caption = 'Unit of Base';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(50002; "Afk_Quantity2"; Code[30])
        {
            Caption = 'Number';
            TableRelation = "Afk_Calc_Parameter";
            DataClassification = CustomerContent;
        }
        field(50003; "Afk_Unit_of_Measure_Code_2"; Code[10])
        {
            Caption = 'Unit of Number';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Item Category Code", "Stockkeeping Unit Exists") { }
    }

}