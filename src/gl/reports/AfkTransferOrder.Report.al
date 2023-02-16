report 50007 AfkTransferOrder
{
    Caption = 'Transfer Order';
    DefaultLayout = RDLC;
    RDLCLayout = './src/gl/reports/layouts/AfkTransferOrder.rdlc';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Document No.");
            RequestFilterFields = "Document No.";
            RequestFilterHeading = 'N° Document';

            column(DocumentNo; GenJournalLine."Document No.")
            {
            }
            column(AfkCompanyPicture; CompanyInfo.Picture)
            {
            }
            column(NumeroText; NumeroText)
            {
            }
            column(LimbeLeText; LimbeLeText)
            {
            }
            column(AttentionText; AttentionText)
            {
            }
            column(ObjectLabel; ObjectLabel)
            {
            }
            column(OVLabel; OVLabel)
            {
            }
            // column(CompanyBankAccountName; CompanyBankAccountName)
            // {
            // }
            column(MonsieurLabel; MonsieurLabel)
            {
            }
            column(ParLeDebitDeText; ParLeDebitDeText)
            {
            }
            column(AmountLabel; AmountLabel)
            {
            }
            column(BenefLabel; BenefLabel)
            {
            }
            column(CompteLabel; CompteLabel)
            {
            }
            column(DomiciliationLabel; DomiciliationLabel)
            {
            }
            column(MotifLabel; MotifLabel)
            {
            }
            column(VeuillezLabel; VeuillezLabel)
            {
            }
            column(AmountText; AmountText)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(VendorRIB; VendorRIB)
            {
            }

            column(VendorBankAccountCode; VendorBankAccountCode)
            {
            }
            column(VendorBankAccountName; VendorBankAccountName)
            {
            }
            column(PaymentBankAccountName; PaymentBankAccountName)
            {
            }

            column(MotifText; MotifText)
            {
            }
            column(ParLeDebitLabel; ParLeDebitLabel)
            {
            }
            column(OuvertLabel; OuvertLabel)
            {
            }
            column(NousVouPrionsLabel; NousVouPrionsLabel)
            {
            }
            column(CompanyRIB; CompanyRIB)
            {
            }
            column(FooterLabel01; FooterInfos[1])
            {
            }
            column(FooterLabel02Text; FooterInfos[2])
            {
            }
            column(FooterLabel03; FooterInfos[3])
            {
            }



            trigger OnAfterGetRecord()
            var
                CompanyBankAccount: Record "Bank Account";
                PayBankAccount: Record "Bank Account";
                Vend: Record Vendor;
                VendBankAccount: Record "Vendor Bank Account";

            begin

                if ("Currency Code" = '') then
                    Currency.Get(GLSetup."LCY Code")
                else
                    Currency.Get("Currency Code");
                CurrencyName := Currency.Description;

                AfkUtils.GetPageFooterInfos(FooterInfos);

                TestField("Account Type", "Account Type"::Vendor);
                TestField("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                TestField("Account No.");
                TestField("Bal. Account No.");
                TestField("Recipient Bank Account");
                CompanyInfo.TestField("Default Bank Account No.");
                CompanyBankAccount.Get(CompanyInfo."Default Bank Account No.");
                PayBankAccount.Get("Bal. Account No.");
                //CompanyBankAccountName := CompanyBankAccount.Name;
                PaymentBankAccountName := PayBankAccount.Name;

                Vend.get("Account No.");
                VendBankAccount.get("Account No.", "Recipient Bank Account");

                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, Amount, Currency.Code);
                Afk_AmountInWords := NoText[1] + ' ' + NoText[2];

                NumeroText := StrSubstNo(NumeroLabel, '_____________', AfkSetup.TransferNoSuffix);
                LimbeLeText := StrSubstNo(LimbeLeLabel, Format("Posting Date", 0, 0));
                AttentionText := StrSubstNo(AttentionDeLabel, PayBankAccount.Contact);
                CompanyRIB := GetRIB(PayBankAccount);
                VendorRIB := VendBankAccount."Bank Branch No." + ' ' + VendBankAccount."Agency Code" + ' ' + VendBankAccount."Bank Account No." + ' ' + Format(VendBankAccount."RIB Key");
                ParLeDebitDeText := StrSubstNo(ParLeDebitLabel, CompanyRIB);
                AmountText := CurrencyName + ' ' + Format(Abs(Amount)) + ' ' + '(' + Afk_AmountInWords + ')';

                VendorName := VendBankAccount.AfkBeneficiary;
                VendorBankAccountCode := VendorRIB;
                VendorBankAccountName := VendBankAccount.Name;
                MotifText := Description;


            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        AfkSetup.Get();
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    local procedure GetRIB(BankAcc: Record "Bank Account"): Text
    begin

        exit(BankAcc."Bank Branch No." + ' ' + BankAcc."Agency Code" + ' ' + BankAcc."Bank Account No." + ' ' + Format(BankAcc."RIB Key"));

    end;

    var
        AfkSetup: Record AfkSetup;
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        RepCheck: Report "Check";
        AfkUtils: Codeunit AfkUtils;
        AmountLabel: Label 'AMOUNT :';
        AttentionDeLabel: Label 'TO THE ATTENTION OF %1';
        BenefLabel: Label 'BENEFICIARY :';
        CompteLabel: Label 'ACCOUNT :';
        DomiciliationLabel: Label 'DOMICILIATION :';
        LimbeLeLabel: Label 'Limbe, on %1';
        MonsieurLabel: Label 'Sir / Madam,';
        MotifLabel: Label 'REASON :';
        NousVouPrionsLabel: Label 'we kindly ask you to make the transfer, the details of which follow :';
        NumeroLabel: Label 'N° %1 %2';
        ObjectLabel: Label 'Object :';
        OuvertLabel: Label ' opened in your books,';
        OVLabel: Label 'Transfer order.';
        ParLeDebitLabel: Label 'By debiting our account No ';
        VeuillezLabel: Label 'Please accept, Sir/Madam, the expression of our best regards.';
        Afk_AmountInWords: Text;
        AmountText: Text;
        AttentionText: Text;
        CompanyBankAccountName: Text;
        CompanyRIB: Text;
        CurrencyName: Text;
        FooterInfos: array[3] of Text;
        LimbeLeText: Text;
        MotifText: Text;
        NoText: array[2] of Text;
        NumeroText: Text;
        ParLeDebitDeText: Text;
        PaymentBankAccountName: Text;
        VendorBankAccountCode: Text;
        VendorBankAccountName: Text;
        VendorName: Text;
        VendorRIB: Text;

}
