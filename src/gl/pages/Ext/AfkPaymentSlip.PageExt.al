pageextension 50035 AfkPaymentSlip extends "Payment Slip"
{
    layout
    {
        addafter("Partner Type")
        {
            field(AfkDescription; Rec.AfkDescription)
            {
                ApplicationArea = Suite;
                MultiLine = true;
            }
        }
    }
}
