table 50004 AfkSetup
{
    Caption = 'AFK Setup';
    //Permissions = TableData "Ins. Coverage Ledger Entry" = r;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Day starting time"; Time)
        {
            Caption = 'Day starting time';
        }
        field(3; "Night starting time"; Time)
        {
            Caption = 'Night starting time';
        }
        field(4; "Purchase Req Nos."; Code[20])
        {
            //AccessByPermission = TableData Insurance = R;
            Caption = 'Purchase Req Nos.';
            TableRelation = "No. Series";
        }




        // field(10; "Insurance Nos."; Code[20])
        // {
        //     AccessByPermission = TableData Insurance = R;
        //     Caption = 'Insurance Nos.';
        //     TableRelation = "No. Series";
        // }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
