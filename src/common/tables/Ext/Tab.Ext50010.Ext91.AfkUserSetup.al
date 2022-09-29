tableextension 50010 AfkUserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Afk_PRType"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
        }
        field(50001; "Afk_POType"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
        }
        field(50002; "AfkPRAmountApprovalLimit"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Requisition Amount Approval Limit';
        }
        field(50003; "AfkUnlimitedPRApproval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unlimited Purchase Requisition Approval';
        }
        field(50004; "AfkCanValidateBudgetTransfer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can Validate Budget Transfer';
        }
    }

}