codeunit 50015 AfkGLMgt
{
    internal procedure SetDefaultDocumentType(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template")
    begin
        if (GenJournalTemplate.Type = GenJournalTemplate.Type::"Cash Receipts") then begin
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        end;
    end;

    internal procedure ChecksOnPostingJournalLine(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        AfkSetup.Get;
        if (AfkSetup.SecurityOnVendorPayment) then begin
            if (GenJournalTemplate.Get(GenJournalLine."Journal Template Name")) then
                if (GenJournalTemplate.Type = GenJournalTemplate.Type::Payments) then begin
                    if (not GenJournalLine.Afk_Authorised) then
                        Error(Error001, GenJournalLine."Line No.");
                end;
        end;
    end;

    internal procedure CheckBankAccountUser(BankAccountCode: Code[20])
    var
        BankAccUser: Record AfkSecurityItem;
    begin
        AfkSetup.Get;
        if (not AfkSetup.SecurityOnBankAccount) then
            exit;

        BankAccUser.SetRange("Account Type", BankAccUser."Account Type"::BankAccount);
        BankAccUser.SetRange("User ID", UserId);
        BankAccUser.SetRange("Account Code", BankAccountCode);
        if (BankAccUser.IsEmpty) then
            Error(Error002, BankAccountCode);

    end;



    var
        AfkSetup: Record AfkSetup;
        Error001: Label 'Line %1 has not been authorized for posting';
        Error002: Label 'You are not authorized to post on this bank account %1';
}
