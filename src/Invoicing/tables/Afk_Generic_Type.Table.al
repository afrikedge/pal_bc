table 50002 Afk_Generic_Type
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(2; RecordType; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = BoatType;
            OptionCaption = 'BoatType';
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Drivable; Boolean)
        {
            Caption = 'Drivable';
            DataClassification = CustomerContent;
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