pageextension 50039 AfkPaymentSlipList extends "Payment Slip List"
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
