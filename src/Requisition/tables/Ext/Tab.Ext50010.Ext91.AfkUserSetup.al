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
        field(50002; "PR Amount Approval Limit"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Requisition Amount Approval Limit';
        }
        field(50003; "Unlimited PR Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unlimited Purchase Requisition Approval';
        }
    }

}