tableextension 50008 AfkStandardSalesLine extends "Standard Sales Line"
{
    fields
    {
        field(50000; "Afk_Quantity1"; Decimal)
        {
            Caption = 'Base';
            //TableRelation = "Afk_Calc_Parameter";
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_Unit_of_Measure_Code_1"; Code[10])
        {
            Caption = 'Unit of Base';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(50002; "Afk_Quantity2"; Decimal)
        {
            Caption = 'Number';
            //TableRelation = "Afk_Calc_Parameter";
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50003; "Afk_Unit_of_Measure_Code_2"; Code[10])
        {
            Caption = 'Unit of Number';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(50006; "Afk_Strip_On_Quay"; Boolean)
        {
            Caption = 'Dockside strip';
            DataClassification = CustomerContent;
        }
        field(50007; "Afk_Road_Access"; Boolean)
        {
            Caption = 'Road access';
            DataClassification = CustomerContent;
        }
        field(50008; "Afk_Water_Network"; Boolean)
        {
            Caption = 'Water Network';
            DataClassification = CustomerContent;
        }
        field(50009; "Afk_Rail_Access"; Boolean)
        {
            Caption = 'Rail access';
            DataClassification = CustomerContent;
        }
        field(50010; "Afk_Elect_Network"; Boolean)
        {
            Caption = 'Electricity Network';
            DataClassification = CustomerContent;
        }
        field(50011; "Afk_Phone_Network"; Boolean)
        {
            Caption = 'Phone Network';
            DataClassification = CustomerContent;
        }
    }

}