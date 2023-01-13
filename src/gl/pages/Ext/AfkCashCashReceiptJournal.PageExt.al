pageextension 50029 AfkCashCashReceiptJournal extends "Cash Receipt Journal"
{
    trigger OnNewRecord(belowxRec: Boolean)
    begin
        Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
    end;
}
