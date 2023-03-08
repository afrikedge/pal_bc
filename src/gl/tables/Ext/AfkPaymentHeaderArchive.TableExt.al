tableextension 50021 AfkPaymentHeaderArchive extends "Payment Header Archive"
{
    fields
    {
        field(50000; "AfkDescription"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
}
