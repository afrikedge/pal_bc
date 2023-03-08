tableextension 50020 AfkPaymentHeader extends "Payment Header"
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
