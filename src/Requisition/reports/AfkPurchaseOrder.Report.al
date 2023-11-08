report 50004 "AfkPurchaseOrder"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/requisition/reports/layouts/AfkPurchaseOrder.rdlc';
    Caption = 'Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';

            //*********************************************************************************************************
            //***********************LABELS**********************************

            column(AfkLblLimbeLe; AfkLimbeLeLbl)
            {
            }
            column(AfkLineHeight; AfkLineHeight)
            {
            }

            column(AfkLblObject; AfkObjectLbl)
            {
            }
            column(AfkLblEmetteur; AfkEmetteurLbl)
            {
            }
            column(AfkLblRefFournisseur; AfkRefFournisseurLbl)
            {
            }
            column(AfkLblNomFournisseur; AfkNomFournisseurLbl)
            {
            }
            column(AfkLblAcheteur; AfkAcheteurLbl)
            {
            }
            column(AfkLblNumDA; AfkNumDALbl)
            {
            }
            column(AfkLblRefProforma; AfkRefProformaLbl)
            {
            }
            column(AfkLblTacheBudgetaire; AfkTacheBudgetaireLbl)
            {
            }
            column(AfkLblAdresseLivraison; AfkAdresseLivraisonLbl)
            {
            }
            column(AfkLblVendorAdress; AfkVendorAdressLbl)
            {
            }
            column(AfkLblLigneNo; AfkLigneNoLbl)
            {
            }
            column(AfkLblLigneQte; AfkLigneQteLbl)
            {
            }
            column(AfkLblLignePU; AfkLignePULbl)
            {
            }
            column(AfkLblLigneDesignation; AfkLigneDesignationLbl)
            {
            }
            column(AfkLblLigneReference; AfkLigneReferenceLbl)
            {
            }
            column(AfkLblLigneTotalHT; AfkLigneTotalHTLbl)
            {
            }
            column(AfkLblLigneTotalTTC; AfkLigneTotalTTCLbl)
            {
            }

            column(AfkLblDureeValidite; AfkDureeValiditeLbl)
            {
            }
            column(AfkLblCondPaiement; AfkCondPaiementLbl)
            {
            }
            column(AfkLblRIBFournisseur; AfkRIBFournisseurLbl)
            {
            }
            column(AfkLblDirecteurDelegue; AfkDirecteurDelegueLbl)
            {
            }
            column(AfkLblVAT1925; AfkVAT1925Lbl)
            {
            }
            column(AfkLblTotalTTCDevise; AfkTotalTTCDeviseLbl)
            {
            }
            column(AfkLblDevise; AfkDeviseLbl)
            {
            }
            column(AfkLblTotalHTDevise; AfkTotalHTDeviseLbl)
            {
            }
            column(AfkNatureBudgetaireLbl; AfkNatureBudgetaireLbl)
            {
            }
            column(AfkLigneUniteLbl; AfkLigneUniteLbl)
            {
            }
            column(QRCode; QRCode)
            {
            }
            column(FooterLabel01; FooterLabel01)
            {
            }
            column(FooterLabel02Text; FooterLabel02Text)
            {
            }
            column(FooterLabel03; FooterLabel03)
            {
            }
            column(AfkLimbeLeText; AfkLimbeLeText)
            {
            }



            //***********************LABELS**********************************
            //*********************************************************************************************************

            //*********************************************************************************************************
            //***********************data**********************************
            column(AfkCompanyPicture; CompanyInfo.Picture)
            {
            }
            column(AfkNumCommande; AfkNumCommande)
            {
            }
            column(Afk_Object; "Purchase Header".Afk_Object)
            {
            }
            column(Afk_VendorNo; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(Afk_VendorName; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(Afk_NumDA; "Purchase Header"."Quote No.")
            {
            }
            column(Afk_VendorOrderNo; "Purchase Header"."Vendor Order No.")
            {
            }
            column(Afk_TaskCode; "Purchase Header"."Shortcut Dimension 1 Code")
            {
            }
            column(Afk_NatureCode; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Afk_CurrencyCode; AfkCurrencyCode)
            {
            }
            column(Afk_Validity; "Purchase Header".Afk_Validity)
            {
            }
            column(Afk_QuoteNumber; "Purchase Header"."Quote No.")
            {
            }
            column(AfkIssuerText; AfkIssuerText)
            {
            }
            column(AfkVendorAddress2; AfkVendorAddress2)
            {
            }
            column(AfkVendorAddress1; AfkVendorAddress1)
            {
            }
            column(AfkCurrencyName; AfkCurrencyName)
            {
            }
            column(AfkCompanyAddress2; AfkCompanyAddress2)
            {
            }
            column(AfkCompanyAddress1; AfkCompanyAddress1)
            {
            }

            column(AfkBankAccountLbl; AfkBankAccountLbl)
            {
            }
            column(AfkVendorAccountLbl; AfkVendorAccountLbl)
            {
            }
            column(AfkVendorBanqueLbl; AfkVendorBanqueLbl)
            {
            }
            column(VendorBankAccountName; VendorBankAccountName)
            {
            }
            column(VendorBankAccountNo; VendorBankAccountNo)
            {
            }

            //***********************data**********************************
            //*********************************************************************************************************




            column(TaxeAmount; "TaxeAmount")
            {
            }
            column(NetToPayAmount; "NetToPayAmount")
            {
            }
            column(TaxeTextLabel; "TaxeTextLabel")
            {
            }
            column(NetToPayLbl; "NetToPayLbl")
            {
            }
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(BuyFromContactPhoneNoLbl; BuyFromContactPhoneNoLbl)
            {
            }
            column(BuyFromContactMobilePhoneNoLbl; BuyFromContactMobilePhoneNoLbl)
            {
            }
            column(BuyFromContactEmailLbl; BuyFromContactEmailLbl)
            {
            }
            column(PayToContactPhoneNoLbl; PayToContactPhoneNoLbl)
            {
            }
            column(PayToContactMobilePhoneNoLbl; PayToContactMobilePhoneNoLbl)
            {
            }
            column(PayToContactEmailLbl; PayToContactEmailLbl)
            {
            }
            column(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
            {
            }
            column(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
            {
            }
            column(BuyFromContactEmail; BuyFromContact."E-Mail")
            {
            }
            column(PayToContactPhoneNo; PayToContact."Phone No.")
            {
            }
            column(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
            {
            }
            column(PayToContactEmail; PayToContact."E-Mail")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReportTitleCopyText; StrSubstNo(Text004, CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchHeader; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Code)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(DimText; DimText)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(LineAmt_PurchLine; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine; Format("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage; CompanyInfo."Home Page")
                        {
                        }
                        column(EMail; CompanyInfo."E-Mail")
                        {
                        }

                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(TotalInclVATText; TotalInclVATText)
                        // {
                        // }

                        // column(VATAmount; VATAmount)
                        // {
                        //     AutoFormatExpression = "Purchase Header"."Currency Code";
                        //     AutoFormatType = 1;
                        // }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(TotalAmountInclVAT; TotalAmountInclVAT)
                        // {
                        //     AutoFormatExpression = "Purchase Header"."Currency Code";
                        //     AutoFormatType = 1;
                        // }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(TotalAmount; TotalAmount)
                        // {
                        //     AutoFormatExpression = "Purchase Header"."Currency Code";
                        //     AutoFormatType = 1;
                        // }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption; "Purchase Line".FieldCaption("No."))
                        {
                        }
                        column(Desc_PurchLineCaption; "Purchase Line".FieldCaption(Description))
                        {
                        }
                        column(Qty_PurchLineCaption; "Purchase Line".FieldCaption(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption; "Purchase Line".FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(AfkNumLigne; AfkNumLigneText)//************
                        {
                        }
                        column(AfkIsLigne; AfkIsLine)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin

                            //*********************************************
                            AfkNumLigne := AfkNumLigne + 1;
                            AfkIsLine := 1;
                            if (AfkNumLigne > 9) then
                                AfkNumLigneText := Format(AfkNumLigne)
                            else
                                AfkNumLigneText := '0' + Format(AfkNumLigne);
                            //**********************************************
                            if Number = 1 then
                                PurchLine.Find('-')
                            else
                                PurchLine.Next;
                            "Purchase Line" := PurchLine;

                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                PurchLine."Line Amount" := 0;

                            if ("Purchase Line"."Item Reference No." <> '') and (not ShowInternalInfo) then
                                "Purchase Line"."No." :=
                                    CopyStr("Purchase Line"."Item Reference No.", 1, MaxStrLen("Purchase Line"."No."));
                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            PurchLine.SetRange("Line No.", 0, PurchLine."Line No.");
                            SetRange(Number, 1, PurchLine.Count);

                            AfkLinesNumber := PurchLine.Count;

                            if (AfkLinesNumber > 10) then begin
                                AfkLineHeight := 0.5;
                            end;

                            AfkNumLigne := 0;
                        end;
                    }
                    dataitem(AfkFooterline; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(AfkNumLigne2; AfkNumLigneText)
                        {
                        }
                        column(AfkIsLine2; AfkIsLine)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            AfkNumLigne := AfkNumLigne + 1;
                            AfkIsLine := 1;
                            if (AfkNumLigne > 9) then
                                AfkNumLigneText := Format(AfkNumLigne)
                            else
                                AfkNumLigneText := '0' + Format(AfkNumLigne);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, 10 - AfkLinesNumber);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, VATAmountLine.Count);
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, VATAmountLine.Count);
                            Clear(VALVATBaseLCY);
                            Clear(VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalPrepmtLineAmount; TotalPrepmtLineAmount)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        column(PrepmtLoopLineNo; PrepmtLoopLineNo)
                        {
                        }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DummyColumn; 0)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                PrepmtDimSetEntry.SetRange("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.Find('-') then
                                    CurrReport.Break();
                            end else
                                if PrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;

                            PrepmtLoopLineNo += 1;
                            TotalPrepmtLineAmount += PrepmtLineAmount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            PrepmtLoopLineNo := 0;
                            TotalPrepmtLineAmount := 0;
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATId; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, PrepmtVATAmountLine.Count);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                    Vend1: Record "Vendor";
                    VendPostingGroup: Record "Vendor Posting Group";
                    TotalHT: decimal;
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
                    PurchLine.DeleteAll();
                    VATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;


                    //****************************
                    //Calc tax
                    //----------------------------
                    TotalHT := VATAmountLine.GetTotalLineAmount(false, "Purchase Header"."Currency Code");
                    Vend1.get("Purchase Header"."Buy-from Vendor No.");
                    VendPostingGroup.get(Vend1."Vendor Posting Group");
                    if (VendPostingGroup.Afk_IR_Pourcent > 0) then begin
                        TaxeAmount := -TotalHT * VendPostingGroup.Afk_IR_Pourcent / 100;
                        TaxeTextLabel := StrSubstNo(IRLbl, Format(VendPostingGroup.Afk_IR_Pourcent));
                    end else begin
                        TaxeAmount := -TotalHT * VendPostingGroup.Afk_TSR_Pourcent / 100;
                        TaxeTextLabel := StrSubstNo(TSRLbl, Format(VendPostingGroup.Afk_TSR_Pourcent));
                    end;
                    NetToPayAmount := TotalHT + TaxeAmount;

                    TaxeAmount := Round(TaxeAmount, AfkCurrency."Amount Rounding Precision");
                    NetToPayAmount := Round(NetToPayAmount, AfkCurrency."Amount Rounding Precision");
                    //****************************



                    PrepmtInvBuf.DeleteAll();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.IsEmpty() then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty() then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrePmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := FormatDocument.GetCOPYText;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode then
                        CODEUNIT.Run(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }
            dataitem(Totals; "Integer")
            {

                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATAmountText; VATAmountLine.VATAmountText)
                {
                }

                column(VATAmount; VATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }

                column(TotalAmountInclVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }

                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }

            }
            trigger OnAfterGetRecord()
            var
                // AfkService: Record Afk_Service;
                Country: Record "Country/Region";
                Vend: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
                typehelp: Codeunit "Type Helper";
                RealRIB: Code[2];
                QRCodeText: Text;
            begin

                //************************
                AfkSetup.get;
                AfkSetup.TestField(AfkSetup."XAF Currency Code");
                "Purchase Header".TestField("Purchase Header".Status, "Purchase Header".Status::Released);
                AfkNumCommande := StrSubstNo(AfkNumCommandeLbl, "Purchase Header"."No.");
                AfkCurrencyCode := "Purchase Header"."Currency Code";
                if ("Purchase Header"."Currency Code" = '') then
                    AfkCurrencyCode := AfkSetup."XAF Currency Code";

                if not Vend.Get("Buy-from Vendor No.") then
                    Clear(Vend);

                if (Vend."Preferred Bank Account Code" <> '') then begin
                    if (VendorBankAccount.get(Vend."No.", Vend."Preferred Bank Account Code")) then begin
                        if (VendorBankAccount.AfkRIBKeyText = '') then
                            RealRIB := Format(VendorBankAccount."RIB Key")
                        else
                            RealRIB := Format(VendorBankAccount.AfkRIBKeyText);
                        VendorBankAccountName := VendorBankAccount.Name;
                        VendorBankAccountNo := VendorBankAccount."Bank Branch No." + ' '
                        + VendorBankAccount."Agency Code" + ' '
                        + VendorBankAccount."Bank Account No." + ' '
                        + FORMAT(RealRIB);
                    end;
                end;
                // VendorBankAccountName:Text;
                //                 VendorBankAccountNo:Text;

                if AfkCurrency.Get(AfkCurrencyCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                AfkCurrency.Get(AfkCurrencyCode);
                //if (AfkService.get("Purchase Header".Afk_IssuerCode)) then
                //    AfkIssuerText := AfkService.Name;
                AfkIssuerText := "Purchase Header".Afk_IssuerCode;

                //AfkLimbeLeText := StrSubstNo(AfkLimbeLeLbl, "Purchase Header"."Order Date");
                AfkLimbeLeText := AfkLimbeLeLbl;

                "Purchase Header".CalcFields("Purchase Header"."Amount Including VAT");

                QRCodeText := StrSubstNo(QRCodeLbl, "Purchase Header"."No.",
                "Purchase Header"."Order Date", "Purchase Header"."Amount Including VAT",
                    Vend.Name);

                //QRCodeText := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
                QRCodeText := CopyStr(QRCodeText, 1, 100);

                QRCode := QRCodeMgt.GenerateQRCode(QRCodeText);
                //************************
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                if Country.get(Vend."Country/Region Code") then;
                AfkCompanyAddress1 := CompanyInfo.Name;
                AfkCompanyAddress2 := CompanyInfo.Address + ' ' + CompanyInfo.City;
                AfkVendorAddress1 := Vend."Address" + ' ' + Vend.City + ' ' + Country.Name;
                AfkVendorAddress2 := Vend."E-Mail" + ' Tel : ' + Vend."Phone No.";


                //'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
                FooterLabel02Text := StrSubstNo(FooterLabel02,
                    CompanyInfo."Stock Capital", CompanyInfo."Registration No."
                    , CompanyInfo."Trade Register", CompanyInfo."APE Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                if BuyFromContact.Get("Buy-from Contact No.") then;
                if PayToContact.Get("Pay-to Contact No.") then;
                PricesInclVATtxt := Format("Prices Including VAT");

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if not IsReportInPreviewMode then
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
            end;

            trigger OnPostDataItem()
            begin
                OnAfterPostDataItem("Purchase Header");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoofCopies; NoOfCopies)
                    {
                        ApplicationArea = Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    // field(ArchiveDocument; ArchiveDocument)
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Archive Document';
                    //     ToolTip = 'Specifies whether to archive the order.';

                    //     trigger OnValidate()
                    //     begin
                    //         if not ArchiveDocument then
                    //             LogInteraction := false;
                    //     end;
                    // }
                    // field(LogInteraction; LogInteraction)
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Log Interaction';
                    //     Enabled = LogInteractionEnable;
                    //     ToolTip = 'Specifies if you want the program to log this interaction.';

                    //     trigger OnValidate()
                    //     begin
                    //         if LogInteraction then
                    //             ArchiveDocument := ArchiveDocumentEnable;
                    //     end;
                    // }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := PurchSetup."Archive Orders";
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        PurchSetup.Get();

        OnAfterInitReport;
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if "Purchase Header".FindSet() then
                repeat
                    "Purchase Header".CalcFields("No. of Archived Versions");
                    SegManagement.LogDocument(13, "Purchase Header"."No.", "Purchase Header"."Doc. No. Occurrence",
                      "Purchase Header"."No. of Archived Versions", DATABASE::Vendor, "Purchase Header"."Buy-from Vendor No.",
                      "Purchase Header"."Purchaser Code", '', "Purchase Header"."Posting Description", '');
                until "Purchase Header".Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then
            InitLogInteraction;
    end;

    var
        AfkSetup: record AfkSetup;
        //************************************************************************************************************

        CompanyInfo: Record "Company Information";
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        AfkCurrency: Record "Currency";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        PurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        VATAmountLine: Record "VAT Amount Line" temporary;
        QRCodeMgt: Codeunit AfkQRCodeMgt;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        Language: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        AfkNumLigneText: Code[2];
        AfkLineHeight: Decimal;
        NetToPayAmount: Decimal;
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        TaxeAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPrepmtLineAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        AfkIsLine: Integer;
        AfkLinesNumber: Integer;
        //************************************************************************************************************
        AfkNumLigne: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        PrepmtLoopLineNo: Integer;
        AfkAcheteurLbl: Label 'Purchaser :';
        AfkAdresseLivraisonLbl: Label 'Shipping Address :';

        AfkBankAccountLbl: Label 'Bank Account :';
        AfkCondPaiementLbl: Label 'Payment terms :';
        AfkDeviseLbl: Label 'Currency';
        AfkDirecteurDelegueLbl: Label 'The Director Delegate';
        AfkDureeValiditeLbl: Label 'Validity Period (Days)';
        AfkEmetteurLbl: Label 'Issuer :';
        AfkLigneDesignationLbl: Label 'Description';
        AfkLigneNoLbl: Label 'No';
        AfkLignePULbl: Label 'Unit price';
        AfkLigneQteLbl: Label 'Qty';
        AfkLigneReferenceLbl: Label 'Reference';
        AfkLigneTotalHTLbl: Label 'Total Excl. VAT';
        AfkLigneTotalTTCLbl: Label 'TOTAL Incl. VAT';
        AfkLigneTVALbl: Label 'VAT';
        AfkLigneUniteLbl: Label 'Unit';
        AfkLimbeLeLbl: Label 'Limbe on ___________________';
        AfkNatureBudgetaireLbl: Label 'Expense nature :';
        AfkNomFournisseurLbl: Label 'Vendor name :';
        AfkNumCommandeLbl: Label 'PURCHASE ORDER %1';
        AfkNumDALbl: Label 'Requisition No';
        AfkObjectLbl: Label 'Object :';
        AfkRefFournisseurLbl: Label 'Vendor No :';
        AfkRefProformaLbl: Label 'Quote Ref';
        AfkRIBFournisseurLbl: Label 'Vendor RIB';
        AfkTacheBudgetaireLbl: Label 'Budgetary Task :';
        AfkTotalHTDeviseLbl: Label 'Total Excl. VAT :';
        AfkTotalTTCDeviseLbl: Label 'Total Incl. VAT :';
        AfkVAT1925Lbl: Label 'VAT 19.25% :';
        AfkVendorAccountLbl: Label 'Account No:';
        AfkVendorAdressLbl: Label 'Vendor Address :';
        AfkVendorBanqueLbl: Label 'Bank :';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        AmountCaptionLbl: Label 'Amount';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
        DocumentDateCaptionLbl: Label 'Document Date';
        EmailIDCaptionLbl: Label 'Email';
        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';

        HdrDimCaptionLbl: Label 'Header Dimensions';
        HomePageCaptionLbl: Label 'Home Page';
        IRLbl: Label 'AIR %1 %';
        LineDimCaptionLbl: Label 'Line Dimensions';
        NetToPayLbl: Label 'Net to pay:';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        QRCodeLbl: Label 'Order : %1 Date : %2 Amount Incl VAT : %3 Vendor : %4';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text004: Label 'Order %1', Comment = '%1 = Document No.';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        TotalCaptionLbl: Label 'Total';
        TSRLbl: Label 'TSR %1 %';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VendNoCaptionLbl: Label 'Vendor No.';

        AfkCompanyAddress1: Text;
        AfkCompanyAddress2: Text;
        AfkCurrencyName: Text;
        AfkVendorAddress1: Text;
        AfkVendorAddress2: Text;

        QRCode: Text;
        VendorBankAccountName: Text;
        VendorBankAccountNo: Text;
        AfkCurrencyCode: Text[20];
        AllowInvDisctxt: Text[30];
        CopyText: Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];

        AfkFormattedTotalVAT: Text[50];
        AfkIssuerText: Text[50];
        AfkLieuAdresseFacturation: Text[50];
        AfkLimbeLeText: Text[50];

        AfkNumCommande: Text[50];
        TaxeTextLabel: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        BuyFromAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        DimText: Text[120];
        FooterLabel02Text: Text[250];



    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;



    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        //with PurchaseHeader do begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FieldCaption("VAT Registration No."));
        //end;
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterInitReport()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterPostDataItem(var PurchaseHeader: Record "Purchase Header")
    begin
    end;
}