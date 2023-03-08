pageextension 50036 AfkPaymentSlipArchive extends "Payment Slip Archive"
{
    layout
    {
        addafter("Amount (LCY)")
        {
            field(AfkDescription; Rec.AfkDescription)
            {
                ApplicationArea = Suite;
                MultiLine = true;
            }
        }
    }
}
