tableextension 50012 AfkSalesInvLine extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Afk_Quantity1"; Decimal)
        {
            Caption = 'Base';
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Afk_Unit_of_Measure_Code_1"; Code[10])
        {
            Caption = 'Unit of Base';
            TableRelation = "Unit of Measure".Code;
        }
        field(50002; "Afk_Quantity2"; Decimal)
        {
            Caption = 'Number';
            DecimalPlaces = 0 : 5;
        }
        field(50003; "Afk_Unit_of_Measure_Code_2"; Code[10])
        {
            Caption = 'Unit of Number';
            TableRelation = "Unit of Measure".Code;
        }
        field(50006; "Afk_Strip_On_Quay"; Boolean)
        {
            Caption = 'Dockside strip';
        }
        field(50007; "Afk_Road_Access"; Boolean)
        {
            Caption = 'Road access';
        }
        field(50008; "Afk_Water_Network"; Boolean)
        {
            Caption = 'Water Network';
        }
        field(50009; "Afk_Rail_Access"; Boolean)
        {
            Caption = 'Rail access';
        }
        field(50010; "Afk_Elect_Network"; Boolean)
        {
            Caption = 'Electricity Network';
        }
        field(50011; "Afk_Phone_Network"; Boolean)
        {
            Caption = 'Phone Network';
        }
        field(500012; "Afk_Printed_Description"; Text[100])
        {
            Caption = 'Printed Description';
        }
    }

    var


}