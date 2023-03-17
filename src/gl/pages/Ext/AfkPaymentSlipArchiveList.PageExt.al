pageextension 50040 AfkPaymentSlipArchiveList extends "Payment Slip List Archive"
{
    layout
    {
        addafter("Payment Class")
        {
            field(AfkDescription; Rec.AfkDescription)
            {
                ApplicationArea = Suite;
                MultiLine = true;
            }
        }
    }
}
