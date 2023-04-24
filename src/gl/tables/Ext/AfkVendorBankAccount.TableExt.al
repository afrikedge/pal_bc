tableextension 50018 AfkVendorBankAccount extends "Vendor Bank Account"
{
    fields
    {
        field(50000; AfkBeneficiary; Text[100])
        {
            Caption = 'Beneficiary';
            DataClassification = CustomerContent;
        }
        field(50001; AfkRIBKeyText; Code[2])
        {
            Caption = 'RIB Code';
            DataClassification = CustomerContent;
        }
    }
}
