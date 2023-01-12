pageextension 50028 AfkVendorBankAccountCard extends "Vendor Bank Account Card"
{
    layout
    {
        addafter(Name)
        {
            field("AfkBeneficiary"; Rec.AfkBeneficiary)
            {
                ApplicationArea = Basic;
            }
        }
    }
}
