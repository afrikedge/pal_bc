table 50001 Afk_Princing
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "EntryNo"; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(3; "Terminal"; Code[10])
        {
            Caption = 'Terminal';
            TableRelation = "Responsibility Center";
        }
        field(4; "BoatType"; Code[20])
        {
            Caption = 'Boat Type';
            TableRelation = "Afk_Generic_Type" where(RecordType = const(BoatType));
        }
        field(5; "Pavillon"; Code[10])
        {
            Caption = 'Terminal';
            TableRelation = "Responsibility Center";
        }
        field(6; "Notes"; Text[100])
        {
            Caption = 'Notes';
        }
        
    }

    keys
    {
        key(PK; "EntryNo")
        {
            Clustered = true;
        }
    }

}