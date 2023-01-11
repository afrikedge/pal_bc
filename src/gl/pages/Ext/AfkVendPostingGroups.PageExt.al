pageextension 50022 AfkVendPostingGroups extends "Vendor Posting Groups"
{
    layout
    {
        addafter("Service Charge Acc.")
        {
            field("Afk_IR_Pourcent"; Rec.Afk_IR_Pourcent)
            {
                ApplicationArea = Basic;
            }
            field("Afk_IR_Account"; Rec.Afk_IR_Account)
            {
                ApplicationArea = Basic;
            }
            field("Afk_TSR_Pourcent"; Rec.Afk_TSR_Pourcent)
            {
                ApplicationArea = Basic;
            }
            field("Afk_TSR_Account"; Rec.Afk_TSR_Account)
            {
                ApplicationArea = Basic;
            }
            field("Afk_VAT_Deduction"; Rec.Afk_VAT_Deduction)
            {
                ApplicationArea = Basic;
            }
            field("Afk_VATWithholding_Account"; Rec.Afk_VATWithholding_Account)
            {
                ApplicationArea = Basic;
            }
        }
    }
}
