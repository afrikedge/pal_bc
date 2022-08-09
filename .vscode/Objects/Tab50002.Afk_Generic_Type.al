table 50002 Afk_Generic_Type
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; RecordType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BoatType;
            OptionCaption = 'BoatType';
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Drivable; Boolean)
        {
            Caption = 'Drivable';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "RecordType", "Code")
        {
            Clustered = true;
        }
    }

}