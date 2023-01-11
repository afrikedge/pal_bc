codeunit 50014 "AfkGLSubs"
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterSetupNewLine', '', true, false)]
    local procedure OnAfterSetupNewLine(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template"; GenJournalBatch: Record "Gen. Journal Batch"; LastGenJournalLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    var
        AfkGLMgt: codeunit AfkGLMgt;
    begin
        AfkGLMgt.SetDefaultDocumentType(GenJournalLine, GenJournalTemplate);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeRunCheck', '', true, false)]
    local procedure OnBeforeRunCheck(var GenJournalLine: Record "Gen. Journal Line")
    var
        AfkGLMgt: codeunit AfkGLMgt;
    begin
        AfkGLMgt.ChecksOnPostingJournalLine(GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeInitBankAccLedgEntry', '', true, false)]
    local procedure OnPostBankAccOnBeforeInitBankAccLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; CurrencyFactor: Decimal; var NextEntryNo: Integer; var NextTransactionNo: Integer; var BankAccPostingGr: Record "Bank Account Posting Group")
    var
        AfkGLMgt: codeunit AfkGLMgt;
    begin
        AfkGLMgt.CheckBankAccountUser(GenJournalLine."Account No.");
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFillInvoicePostBufferOnAfterInitAmounts', '', true, false)]
    // local procedure OnAfterInitVATAmounts_VendDeductions(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchLineACY: Record "Purchase Line"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var TotalAmount: Decimal; var TotalAmountACY: Decimal)
    // var
    //     AfkGLMgt: codeunit Afk_vendorDeductionMgt;
    // begin
    //     AfkGLMgt.PostVendorDeductions1(PurchHeader, PurchLine, PurchLineACY, InvoicePostBuffer, TempInvoicePostBuffer, TotalAmount, TotalAmountACY);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostVendorEntry', '', true, false)]
    local procedure OnAfterInitVATAmounts_VendDeductions(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        AfkGLMgt: codeunit Afk_vendorDeductionMgt;
    begin
        AfkGLMgt.PostVendorDeductions(PurchHeader, GenJnlLine."Document Type", GenJnlLine."Document No.", GenJnlLine."External Document No.",
        GenJnlLine."Source Code", GenJnlPostLine, TotalPurchLineLCY, TotalPurchLine);
    end;







}
