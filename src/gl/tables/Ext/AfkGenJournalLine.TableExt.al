tableextension 50017 AfkGenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(50000; Afk_Authorised; Boolean)
        {
            Caption = 'Authorised';
            DataClassification = CustomerContent;
        }

        field(50001; Afk_Beneficiary; Text[100])
        {
            Caption = 'Beneficiary';
            DataClassification = CustomerContent;
        }
        field(50002; Afk_RIBAccount; Text[100])
        {
            Caption = 'Account';
            DataClassification = CustomerContent;
        }
        field(50003; Afk_Domiciliation; Text[100])
        {
            Caption = 'Domiciliation';
            DataClassification = CustomerContent;
        }
    }
}
