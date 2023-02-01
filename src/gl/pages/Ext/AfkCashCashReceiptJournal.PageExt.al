pageextension 50029 AfkCashCashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Applies-to Doc. No.")
        {
            field(Afk_PaymentMethodCode; Rec."Payment Method Code")
            {
                ApplicationArea = Suite;
            }
        }
    }

    trigger OnNewRecord(belowxRec: Boolean)
    var
        GenJrnBatch: Record "Gen. Journal Batch";
    begin
        Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
        // if (GenJrnBatch.get(Rec."Journal Template Name", Rec."Journal Batch Name")) then
        //     if GenJrnBatch.AfkPaymentMethodCode <> '' then
        //         Rec.Validate("Payment Method Code", GenJrnBatch.AfkPaymentMethodCode);
    end;
}
