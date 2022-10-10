table 50007 AfkDocRequisitionBudget
{
    Caption = 'Purchase Requisition Budget Line';
    //DrillDownPageID = "Purchase Lines";
    //LookupPageID = "Purchase Lines";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "G/L Account No"; Code[20])
        {
            Caption = 'G/L Account No.';
            Editable = false;
        }
        field(4; "G/L Account Name"; Text[100])
        {
            Caption = 'G/L Account Name';
        }
        field(5; "Dimension Code 1"; Code[20])
        {
            Caption = 'Task Code';
            Editable = false;
        }
        field(6; "Dimension Code 2"; Code[20])
        {
            Caption = 'Dimension Code 2';
            Editable = false;
        }

        field(7; "Global Dimension 1 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(8; "Global Dimension 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(9; "Budget Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(10; "Net Change"; Decimal)

        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("G/L Account No"),
                    "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                    "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                    "Posting Date" = FIELD("Date Filter")
                    ));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Budget Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(13; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("G/L Account No"),
                    "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                    "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                    Date = FIELD("Date Filter"),
                    "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budgeted Amount';
            FieldClass = FlowField;
            Editable = false;
        }
        field(14; "Commitment Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Commitment Amount';
            Editable = false;
        }
        field(15; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(16; "Document Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Document Amount';
            Editable = false;
        }
        field(17; "Net Change Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Net Change Value';
            Editable = false;
        }
        // field(18; "Budgeted Amount Value"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Budgeted Amount Value';
        //     Editable = false;
        // }
        field(19; "Cumul Budgeted Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cumulated Budgeted Amt';
            Editable = false;
        }
        field(20; "Monthly Budgeted Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Monthly Budgeted Amt';
            Editable = false;
        }
        field(21; "Yearly Budgeted Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Yearly Budgeted Amt';
            Editable = false;
        }
        field(22; "Monthly Commitment"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Monthly Commitment';
            Editable = false;
        }

        field(23; "Cumul Commitment"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Acc Commitment';
            Editable = false;
        }
        field(44; "Yearly PreCommitment"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Yearly Pre-Commitment';
            Editable = false;
        }
        field(33; "Yearly Commitment"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Yearly Commitment';
            Editable = false;
        }
        field(24; "Monthly Realized Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Monthly Realized Amt';
            Editable = false;
        }
        field(34; "Yearly Realized Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Yearly Realized Amt';
            Editable = false;
        }
        field(25; "Cumul Realized Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cumulated Realized Amt';
            Editable = false;
        }
        field(26; "Monthly Available Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Monthly Available Amt';
            Editable = false;
        }
        field(36; "Yearly Available Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Yearly Available Amt';
            Editable = false;
        }
        field(27; "Cumul Available Amt"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cumulated Available Amt';
            Editable = false;
        }
        field(28; "UserID"; Code[100])
        {
            Caption = 'User Id';
        }

    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "G/L Account No", "Dimension Code 1")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "UserID")
        {

        }
    }


}