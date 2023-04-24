tableextension 50022 AfkBankAccount extends "Bank Account"
{
    fields
    {
        field(50000; AfkRIBKeyText; Code[2])
        {
            Caption = 'RIB Code';
            DataClassification = CustomerContent;
        }
    }
}
