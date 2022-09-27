table 50000 Afk_Calc_Parameter
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; DataType; Option)
        {
            Caption = 'Parameter Type';
            DataClassification = ToBeClassified;
            OptionMembers = Fixe,Calculated;
            OptionCaption = 'Fixe,Calculated';
        }
        field(4; Value; Decimal)
        {
            Caption = 'Value';
        }
        field(5; System; Boolean)
        {
            Caption = 'System Parameter';
        }
        field(6; Notes; Text[100])
        {
            Caption = 'Notes';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}