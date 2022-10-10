tableextension 50010 AfkUserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Afk_PRType"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_POType"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
            DataClassification = CustomerContent;
        }
        field(50002; "Afk_PRAmountApprovalLimit"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Requisition Amount Approval Limit';
        }
        field(50003; "Afk_UnlimitedPRApproval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Unlimited Purchase Requisition Approval';
        }
        field(50004; "Afk_CanValidateBudgetTransfer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Can Validate Budget Transfer';
        }
        field(50005; "Afk_CanValidateBudgetRevision"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Can Validate Budget Revision';
        }
        field(50006; "Afk_CanUpdateNotificationInfos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Modify notification date';
        }
        field(50007; "Afk_CanSkipBudgetControl"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Skip Budget control';
        }
        field(50008; "Afk_DefaultTask"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Task';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50009; "Afk_DefaultNature"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Nature';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true),
                Blocked = const(true));
        }
    }

}