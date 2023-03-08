codeunit 50017 Afk_vendorDeductionMgt
{

    procedure PostVendorDeductions(PurchHeader: Record "Purchase Header"; VendorGenJnlLine: Record "Gen. Journal Line";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLineLCY: Record "Purchase Line";
        var TotalPurchLine: Record "Purchase Line")
    var
        Vend: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
    begin

        AddOnSetup.Get();
        if (not AddOnSetup.VendorDeductionMgt) then exit;

        Vend.Get(PurchHeader."Pay-to Vendor No.");
        VendorPostingGroup.Get(Vend."Vendor Posting Group");

        if (VendorPostingGroup.Afk_IR_Pourcent > 0) then begin
            VendorPostingGroup.TestField(Afk_IR_Account);
            PostVendor_IR_TSR(PurchHeader, VendorPostingGroup.Afk_IR_Account,
                VendorPostingGroup.Afk_IR_Pourcent, VendorGenJnlLine, GenJnlPostLine, TotalPurchLineLCY, TotalPurchLine, false);
        end;

        if (VendorPostingGroup.Afk_TSR_Pourcent > 0) then begin
            VendorPostingGroup.TestField(Afk_TSR_Account);
            PostVendor_IR_TSR(PurchHeader, VendorPostingGroup.Afk_TSR_Account,
                VendorPostingGroup.Afk_TSR_Pourcent, VendorGenJnlLine, GenJnlPostLine, TotalPurchLineLCY, TotalPurchLine, false);
        end;

        if (VendorPostingGroup.Afk_VAT_Deduction) then begin
            VendorPostingGroup.TestField(Afk_VATWithholding_Account);
            PostVendor_IR_TSR(PurchHeader, VendorPostingGroup.Afk_VATWithholding_Account,
                0, VendorGenJnlLine, GenJnlPostLine, TotalPurchLineLCY, TotalPurchLine, true);
        end;
    end;



    local procedure PostVendor_IR_TSR(PurchHeader: Record "Purchase Header"; AccountNo: Code[20]; AmtPourcentage: decimal;
    VendorGenJnlLine: Record "Gen. Journal Line";
    var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLineLCY: Record "Purchase Line"; var TotalPurchLine: Record "Purchase Line"; IsVATDeduction: Boolean)
    var
        Currency: Record Currency;
        GenJnlLine: Record "Gen. Journal Line";
        SourceDeductionBaseAmt: Decimal;
        SourceDeductionBaseAmtLCY: Decimal;
    begin

        IF PurchHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(PurchHeader."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;

        GenJnlLine.INIT;
        GenJnlLine."Posting Date" := PurchHeader."Posting Date";
        GenJnlLine."Document Date" := PurchHeader."Document Date";
        GenJnlLine.Description := PurchHeader."Posting Description";
        GenJnlLine."Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := PurchHeader."Dimension Set ID";
        GenJnlLine."Reason Code" := PurchHeader."Reason Code";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        GenJnlLine."Account No." := PurchHeader."Pay-to Vendor No.";
        //IF "Document Type" = "Document Type"::"Credit Memo" THEN
        //  GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
        //ELSE
        //  GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := VendorGenJnlLine."Document No.";
        GenJnlLine."External Document No." := VendorGenJnlLine."External Document No.";

        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := AccountNo;
        GenJnlLine."Currency Code" := PurchHeader."Currency Code";

        if (not IsVATDeduction) then begin
            SourceDeductionBaseAmtLCY := TotalPurchLineLCY.Amount;
            SourceDeductionBaseAmt :=
              CurrExchRate.ExchangeAmtLCYToFCY(
                PurchHeader."Posting Date", PurchHeader."Currency Code",
                SourceDeductionBaseAmtLCY, PurchHeader."Currency Factor");
            GenJnlLine.Amount := ROUND(SourceDeductionBaseAmt * (AmtPourcentage / 100), Currency."Amount Rounding Precision");
            GenJnlLine."Amount (LCY)" := ROUND(SourceDeductionBaseAmtLCY * (AmtPourcentage / 100));
        end else begin
            GenJnlLine.Amount := ROUND(TotalPurchLine."Amount Including VAT" - TotalPurchLine.Amount, Currency."Amount Rounding Precision");
            GenJnlLine."Amount (LCY)" := ROUND(TotalPurchLineLCY."Amount Including VAT" - TotalPurchLineLCY.Amount);
        end;



        GenJnlLine.Correction := PurchHeader.Correction;
        GenJnlLine."Source Currency Code" := PurchHeader."Currency Code";
        GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;


        IF PurchHeader."Currency Code" = '' THEN
            GenJnlLine."Currency Factor" := 1
        ELSE
            GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";
        GenJnlLine."Applies-to Doc. Type" := VendorGenJnlLine."Document Type";
        GenJnlLine."Applies-to Doc. No." := VendorGenJnlLine."Document No.";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := PurchHeader."Pay-to Vendor No.";
        GenJnlLine."Source Code" := VendorGenJnlLine."Source Code";
        GenJnlLine."Posting No. Series" := PurchHeader."Posting No. Series";
        GenJnlLine."IC Partner Code" := PurchHeader."Pay-to IC Partner Code";
        GenJnlLine."Allow Zero-Amount Posting" := TRUE;
        GenJnlLine."Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    var
        AddOnSetup: Record AfkSetup;
        CurrExchRate: Record "Currency Exchange Rate";
}
