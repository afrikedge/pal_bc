table 50004 AfkSetup
{
    Caption = 'AFK Setup';
    //Permissions = TableData "Ins. Coverage Ledger Entry" = r;
    DataClassification = CustomerContent;

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
            Caption = 'Item Requisition Nos.';
            TableRelation = "No. Series";
        }

        field(5; "Default Budget Code"; Code[10])
        {
            Caption = 'Active Budget Code';
            TableRelation = "G/L Budget Name";
        }
        field(6; "Budget Period"; Option)
        {
            Caption = 'Budget Period';
            OptionMembers = "None","Year","Month";
            OptionCaption = 'None,Year,Month';
        }
        field(7; "PR Max Value"; Decimal)
        {
            Caption = 'Purch Requisition Max Value';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        // field(8; "PO Max Value"; Decimal)
        // {
        //     Caption = 'Commitment Max Value';
        //     DecimalPlaces = 0 : 5;
        //     MinValue = 0;
        // }
        field(9; "Whse Delivery Nos."; Code[20])
        {
            Caption = 'Item Delivery Nos.';
            TableRelation = "No. Series";
        }
        field(50009; BudgetControlMode; Enum AfkBudgetControlMode)
        {
            Caption = 'Budget Control Mode';
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

