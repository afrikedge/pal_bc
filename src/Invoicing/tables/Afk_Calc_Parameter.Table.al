table 50000 Afk_Calc_Parameter
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[30])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; DataType; Option)
        {
            Caption = 'Parameter Type';
            DataClassification = CustomerContent;
            OptionMembers = Fixe,Calculated;
            OptionCaption = 'Fixe,Calculated';
        }
        field(4; Value; Decimal)
        {
            Caption = 'Value';
            DataClassification = CustomerContent;
        }
        field(5; System; Boolean)
        {
            Caption = 'System Parameter';
            DataClassification = CustomerContent;
        }
        field(6; Notes; Text[100])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
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