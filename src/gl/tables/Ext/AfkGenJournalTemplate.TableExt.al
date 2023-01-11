tableextension 50016 AfkGenJournalTemplate extends "Gen. Journal Template"
{
    fields
    {
        field(50000; "AfkAccountType"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Default Account Type';
            DataClassification = CustomerContent;
        }
    }
}
