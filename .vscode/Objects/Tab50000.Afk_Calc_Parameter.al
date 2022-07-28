table 50000 Afk_Calc_Parameter
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; DataType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Fixe,Calculated;
            OptionCaption = 'Fixe,Calculated';
        }
        field(4; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; System; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Notes; Text[100])
        {
            DataClassification = ToBeClassified;
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