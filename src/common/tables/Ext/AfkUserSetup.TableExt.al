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
    }

}