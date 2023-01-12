tableextension 50018 AfkVendorBankAccount extends "Vendor Bank Account"
{
    fields
    {
        field(50000; AfkBeneficiary; Text[100])
        {
            Caption = 'Beneficiary';
            DataClassification = CustomerContent;
        }
    }
}
