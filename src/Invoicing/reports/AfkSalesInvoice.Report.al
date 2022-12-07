report 50000 "AfkSalesInvoicePreview"
{
    RDLCLayout = './src/Invoicing/reports/layouts/AfkSalesInvoicePreview.rdlc';
    WordLayout = './src/Invoicing/reports/layouts/AfkSalesInvoicePreview.docx';
    Caption = 'PAL Sales Invoice Preview';
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Invoice';

            //*************************************ENtete*************************************************************
            column(Afk_LieuDateFacturation; AfkLieuAdresseFacturation)
            {
            }
            column(Afk_Invoice_Object; Header.Afk_Invoice_Object)
            {
            }
            column(Afk_Terminal; Header."Responsibility Center")
            {
            }
            column(Afk_BoatType; AfkBoat.BoatType)
            {
            }
            column(Afk_BoatName; AfkBoat.Name)
            {
            }
            column(Afk_UserID; USERID)
            {
            }
            column(Afk_Contribuable; Cust.Afk_Tax_Number)
            {
            }
            column(Afk_RegistreCommerce; Cust.Afk_TradeRegister)
            {
            }
            column(Afk_CurrencyCode; AfkCurrCode)
            {
            }
            column(AfkTerminalLbl; AfkTerminalLbl)
            {
            }
            column(AfkTypeNavireLbl; AfkTypeNavireLbl)
            {
            }
            column(AfkNomNavireLbl; AfkNomNavireLbl)
            {
            }
            column(AfkDateLieuFacturationLbl; AfkDateLieuFacturationLbl)
            {
            }
            column(AfkAgentFacturationLbl; AfkAgentFacturationLbl)
            {
            }
            column(AfkAddresseFacturationLbl; AfkAddresseFacturationLbl)
            {
            }
            column(AfkAddresseFacturationClientLbl; AfkAddresseFacturationClientLbl)
            {
            }
            column(AfkCodeClientLbl; AfkCodeClientLbl)
            {
            }
            column(AfkNomClientLbl; AfkNomClientLbl)
            {
            }
            column(AfkNumContribuableLbl; AfkNumContribuableLbl)
            {
            }
            column(AfkRCCMLbl; AfkRCCMLbl)
            {
            }
            column(AfkLigneNoLbl; AfkLigneNoLbl)
            {
            }
            column(AfkLigneQteLbl; AfkLigneQteLbl)
            {
            }
            column(AfkLignePULbl; AfkLignePULbl)
            {
            }
            column(AfkLigneTVALbl; AfkLigneTVALbl)
            {
            }
            column(AfkLigneTotalHTLbl; AfkLigneTotalHTLbl)
            {
            }
            column(AfkLignePrestationsLbl; AfkLignePrestationsLbl)
            {
            }
            column(AfkLigneTotalTTCLbl; AfkLigneTotalTTCLbl)
            {
            }

            column(AfkCondPaiementLbl; AfkCondPaiementLbl)
            {
            }
            column(AfkCompteAfrilandLbl; AfkCompteAfrilandLbl)
            {
            }
            column(AfkVAT1925Lbl; AfkVAT1925Lbl)
            {
            }
            column(AfkTotalTTCDeviseLbl; AfkTotalTTCDeviseLbl)
            {
            }
            column(AfkDeviseLbl; AfkDeviseLbl)
            {
            }
            column(AfkTotalHTDeviseLbl; AfkTotalHTDeviseLbl)
            {
            }
            column(AfkArreteMontantLbl; AfkArreteMontantLbl)
            {
            }
            column(AfkLieuAdresseFacturation; AfkLieuAdresseFacturation)
            {
            }

            column(AfkBaseCaptionLbl; AfkBaseCaptionLbl)
            {
            }


            column(AfkCustName; Cust.Name)
            {
            }
            column(AfkCustNo; Cust."No.")
            {
            }
            column(AfkInvNoLbl; InvNoLbl)
            {
            }
            column(AfkObjectLbl; AfkObjectLbl)
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
            column(AfkCompanyAddress1; AfkCompanyAddress1)
            {
            }
            column(AfkCompanyAddress2; AfkCompanyAddress2)
            {
            }
            column(AfkCompanyAddress3; AfkCompanyAddress3)
            {
            }
            column(AfkCustomerAddress1; AfkCustomerAddress1)
            {
            }
            column(AfkCustomerAddress2; AfkCustomerAddress2)
            {
            }
            column(AfkCustomerAddress3; AfkCustomerAddress3)
            {
            }
            column(BankAccount1; BankAccount1)
            {
            }
            column(BankAccount2; BankAccount2)
            {
            }
            column(AfkCurrencyName; AfkCurrencyName)
            {
            }
            column(AfkLocalCurrencyName; AfkLocalCurrencyName)
            {
            }
            column(AfkCompanyBanqueLbl; AfkCompanyBanqueLbl)
            {
            }
            column(AfkCompanyAccountLbl; AfkCompanyAccountLbl)
            {
            }
            column(BankAccountLbl; BankAccountLbl)
            {
            }





            // AfkTotalAmountInclVAT_LCYText := '';
            //             AfkLocalCurrencyText := '';
            //             AfkTotalAmount_LCYText := '';
            //             AfkTotalVAT_LCYText := '';
            //             AfkLocalCurrencyCaption := '';
            //             AfkTotalAmount_LCYCaption := '';
            //             AfkTotalVAT_LCYCaption := '';
            //             AfkTotalAmountInclVAT_LCYCaption := '';
            //****************************************************************************************














            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; DummyCompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            // column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            // {
            // }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            // column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            // {
            // }
            column(CompanyBankName; CompanyBankAccount.Name)
            {
            }
            // column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            // {
            // }
            column(CompanyBankBranchNo; CompanyBankAccount."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyBankAccount.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyBankAccount."Bank Account No.")
            {
            }
            // column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            // {
            // }
            column(CompanyIBAN; CompanyBankAccount.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyBankAccount.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyBankAccount."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyBankAccount.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(TextApercu; TextApercu)
            {
            }

            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            // column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            // {
            // }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            // column(Shipment_Lbl; ShipmentLbl)
            // {
            // }
            // column(ShowShippingAddress; ShowShippingAddr)
            // {
            // }
            // column(ShipToAddress_Lbl; ShiptoAddrLbl)
            // {
            // }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }

            // column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            // {
            // }
            // column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            // {
            // }
            // column(SellToContactEmailLbl; SellToContactEmailLbl)
            // {
            // }
            // column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            // {
            // }
            // column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            // {
            // }
            // column(BillToContactEmailLbl; BillToContactEmailLbl)
            // {
            // }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            // column(OrderNo; "Order No.")
            // {
            // }
            // column(OrderNo_Lbl; FieldCaption("Order No."))
            // {
            // }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            // column(SalesPerson_Lbl; SalespersonLbl)
            // {
            // }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
            }
            column(SellToFaxNo; GetSellToCustomerFaxNo)
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            // column(PaymentReference; GetPaymentReference)
            // {
            // }
            column(From_Lbl; FromLbl)
            {
            }
            column(BilledTo_Lbl; BilledToLbl)
            {
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
            }
            // column(PaymentReference_Lbl; GetPaymentReferenceLbl)
            // {
            // }
            column(LegalEntityType; Cust.GetLegalEntityType)
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
            }
            // column(Copy_Lbl; CopyLbl)
            // {
            // }
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            // column(HomePage_Header_Lbl; HomePageLbl)
            // {
            // }
            // column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            // {
            // }
            // column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            // {
            // }
            // column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            // {
            // }
            // column(LocalCurrency_Lbl; LocalCurrencyLbl)
            // {
            // }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            // column(Page_Lbl; PageLbl)
            // {
            // }
            // column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            // {
            // }
            column(Questions_Lbl; QuestionsLbl)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText)
            {
            }
            column(DocumentTitle_Lbl; DocumentCaption)
            {
            }
            // column(YourDocumentTitle_Lbl; YourSalesInvoiceLbl)
            // {
            // }
            column(Thanks_Lbl; ThanksLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }
            column(RemainingAmountText; RemainingAmountTxt)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            // column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            // {
            // }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            // column(VATIdentifier_Lbl; VATIdentifierLbl)
            // {
            // }
            // column(VATPercentage_Lbl; VATPercentageLbl)
            // {
            // }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No."))
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(AfkIsLine; AfkIsLine)
                {
                }
                //*************LIGNES**LIGNES**LIGNES**************************************************
                column(AfkNumLigne; NumLigneText)
                {
                }
                column(AfkLigneBase; AfkFormattedBase)
                {
                }
                column(AfkLigneQte; AfkFormattedNumber)
                {
                }
                column(AfkLignePrintedDescr; Line.Afk_Printed_Description)
                {
                }
                column(AfkAmountVAT_Line; AfkFormattedVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AfkFormattedBase; AfkFormattedBase)
                {
                }
                column(AfkFormattedNumber; AfkFormattedNumber)
                {
                }
                column(AfkFormattedVAT; AfkFormattedVAT)
                {
                }
                //*************LIGNES**LIGNES**LIGNES**************************************************
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(Description_Line; Line.Afk_Printed_Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(AfkLineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AfkLineAmountTTC_Line; FormattedLineAmountTTC)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                // column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                // {
                // }
                column(Quantity_Line; FormattedQuantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobNo; JobNo)
                {
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(Qty_Lbl; QtyLbl)
                {
                }
                column(Price_Lbl; PriceLbl)
                {
                }
                column(PricePer_Lbl; PricePerLbl)
                {
                }
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    //******************************************************LIGNE**********************
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);

                    if Line.Type = Line.Type::" " then begin
                        AfkFormattedBase := '';
                        AfkFormattedNumber := '';
                        AfkFormattedVAT := '';
                    end else begin
                        // AfkFormattedBase := Format(Line.Afk_Quantity1);
                        // AfkFormattedNumber := Format(Line.Afk_Quantity2);
                        AfkFormattedBase := Format(Round(Line.Afk_Quantity1, 2));
                        AfkFormattedNumber := Format(Round(Line.Quantity, 2));
                        AfkFormattedVAT := Format("Amount Including VAT" - "Line Amount", 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                        FormattedLineAmountTTC := Format("Amount Including VAT", 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    end;
                    ;

                    //**************************************************LIGNE**********************
                    InitializeShipmentLine;
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    VATAmountLine.Init();
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    VATAmountLine.InsertLine();

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    JobNo := "Job No.";
                    JobTaskNo := "Job Task No.";

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    AfkLinesNumber := Count();
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;

                    OnAfterLineOnPreDataItem(Header, Line);
                end;


            }
            dataitem(AfkFooterline; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(AfkNumLigne2; NumLigneText)
                {
                }
                column(AfkIsLine2; AfkIsLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AfkIsLine := 1;
                    NumLigne := NumLigne + 1;
                    if (NumLigne < 10) then
                        NumLigneText := '0' + Format(NumLigne)
                    else
                        NumLigneText := Format(NumLigne);
                end;

                trigger OnPreDataItem()
                begin
                    // if (AfkLinesNumber < 10) then
                    //     SetRange(Number, 1, 10 - AfkLinesNumber)
                    // else
                    SetRange(Number, 1, 14 - AfkLinesNumber);
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 99999));
                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }

                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator);
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                // column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                // {
                // }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;

                    if ShowVATClause("VAT Clause Code") then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATClausesHeader; VATClausesText)
                {
                }
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClause.Description)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip();
                    VATClause.GetDescription(Header);
                end;

                trigger OnPreDataItem()
                begin
                    if Count = 0 then
                        VATClausesText := ''
                    else
                        VATClausesText := VATClausesLbl;
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines;
                end;
            }
            dataitem(LineFee; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));
                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not DisplayAdditionalFeeNote then
                        CurrReport.Break();

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FindSet() then
                            CurrReport.Break
                    end else
                        if TempLineFeeNoteOnReportHist.Next() = 0 then
                            CurrReport.Break();
                end;
            }
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            {
                DataItemTableView = SORTING(Key);
                UseTemporary = true;
                column(PaymentServiceLogo; Logo)
                {
                }
                column(PaymentServiceLogo_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceLogo_Url; GetTargetURL)
                {
                }
                column(PaymentServiceText_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceText_Url; GetTargetURL)
                {
                }
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyLbl)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
                column(PmtDiscText; PmtDiscText)
                {
                }

                trigger OnPreDataItem()
                begin
                    PmtDiscText := '';
                    if Header."Payment Discount %" <> 0 then
                        PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(TotalNetAmount; Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmount; Format(TotalAmountVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; Format(TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalSubTotal; Format(TotalSubTotal, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalSubTotalMinusInvoiceDiscount; Format(TotalSubTotal + TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalAmountExclInclVAT; Format(TotalAmountExclInclVATValue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
                {
                }
                //**************************************************************************
                column(AfkFormattedTotalVAT; AfkFormattedTotalVAT)
                {
                }
                column(AfkFormattedTotalHT; AfkFormattedTotalHT)
                {
                }
                column(AfkFormattedTotalTTC; AfkFormattedTotalTTC)
                {
                }
                column(AfkTotalAmount_LCYText; AfkTotalAmount_LCYText)
                {
                }
                column(Afk_AmountInWords; Afk_AmountInWords)
                {
                }
                column(AfkTotalAmountInclVAT_LCYText; AfkTotalAmountInclVAT_LCYText)
                {
                }
                column(AfkTotalVAT_LCYText; AfkTotalVAT_LCYText)
                {
                }
                column(AfkLocalCurrencyText; AfkLocalCurrencyText)
                {
                }
                column(AfkLocalCurrencyCaption; AfkLocalCurrencyCaption)
                {
                }
                column(AfkTotalVAT_LCYCaption; AfkTotalVAT_LCYCaption)
                {
                }
                column(AfkTotalAmount_LCYCaption; AfkTotalAmount_LCYCaption)
                {
                }
                column(AfkTotalAmountInclVAT_LCYCaption; AfkTotalAmountInclVAT_LCYCaption)
                {
                }
                //**************************************************************************

                trigger OnPreDataItem()
                var
                    QRCodeText: Text;
                begin
                    if Header."Prices Including VAT" then begin
                        TotalAmountExclInclVATTextValue := TotalExclVATText;
                        TotalAmountExclInclVATValue := TotalAmount;
                    end else begin
                        TotalAmountExclInclVATTextValue := TotalInclVATText;
                        TotalAmountExclInclVATValue := TotalAmountInclVAT;
                    end;

                    //******************************************************Sales Header************************************



                    AfkFormattedTotalVAT :=
                        Format(TotalAmountVAT, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    AfkFormattedTotalHT :=
                        Format(TotalAmount, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                    AfkFormattedTotalTTC :=
                        Format(TotalAmountExclInclVATValue, 0,
                        AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));


                    AfkTotalAmountInclVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmountExclInclVATValue, Header."Currency Factor");
                    AfkTotalAmount_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmount, Header."Currency Factor");
                    AfkTotalVAT_LCY := CurrencyExchangeRate.ExchangeAmtFCYToLCY(Header."Posting Date",
                        Header."Currency Code", TotalAmountVAT, Header."Currency Factor");

                    AfkTotalAmountInclVAT_LCY := ROUND(AfkTotalAmountInclVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    AfkTotalAmount_LCY := ROUND(AfkTotalAmount_LCY, AfkLocalCurrency."Amount Rounding Precision");
                    AfkTotalVAT_LCY := ROUND(AfkTotalVAT_LCY, AfkLocalCurrency."Amount Rounding Precision");



                    if ((Header."Currency Factor" = 1) or (Header."Currency Factor" = 0)) then begin
                        AfkTotalAmountInclVAT_LCYText := '';
                        AfkLocalCurrencyText := '';
                        AfkTotalAmount_LCYText := '';
                        AfkTotalVAT_LCYText := '';
                        AfkLocalCurrencyCaption := '';
                        AfkTotalAmount_LCYCaption := '';
                        AfkTotalVAT_LCYCaption := '';
                        AfkTotalAmountInclVAT_LCYCaption := '';
                    end else begin
                        AfkTotalAmountInclVAT_LCYText :=
                            Format(AfkTotalAmountInclVAT_LCY, 0,
                            AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                        AfkTotalAmount_LCYText :=
                            Format(AfkTotalAmount_LCY, 0,
                            AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                        AfkLocalCurrencyText := 'XAF';
                        AfkTotalVAT_LCYText :=
                            Format(AfkTotalVAT_LCY, 0,
                            AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code"));
                        AfkLocalCurrencyCaption := AfkDeviseLbl;
                        AfkTotalAmount_LCYCaption := AfkTotalHTCFALbl;
                        AfkTotalVAT_LCYCaption := AfkVAT1925Lbl;
                        AfkTotalAmountInclVAT_LCYCaption := AfkTotalTTCCFALbl;
                    end;
                    ;

                    RepCheck.InitTextVariable();
                    //RepCheck.FormatNoText(NoText, AfkTotalAmountInclVAT_LCY, Header."Currency Code");
                    RepCheck.FormatNoText(NoText, ROUND(AfkTotalAmountInclVAT_LCY), AfkSetup."XAF Currency Code");
                    //RepCheck.FormatNoTextFR(NoText, AfkTotalAmountInclVAT_LCY, '');
                    Afk_AmountInWords := NoText[1];

                    QRCodeText := StrSubstNo(QRCodeLbl, "Header"."No.", "Header"."Document Date", AfkTotalAmountInclVAT_LCY);
                    QRCode := QRCodeMgt.GenerateQRCode(QRCodeText);
                    //******************************************************************************************

                end;

                trigger OnAfterGetRecord()//************************Sales Header*******************************************
                begin

                end;
            }

            trigger OnAfterGetRecord()
            var

                PaymentServiceSetup: Record "Payment Service Setup";

            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                //if not IsReportInPreviewMode then
                //    CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", Header);

                AfkSetup.Get();
                AfkSetup.TestField("XAF Currency Code");

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                AfkCurrCode := Header."Currency Code";
                if (AfkCurrCode = '') then
                    AfkCurrCode := GLSetup."LCY Code";

                AfkCurrencyName := AfkCurrCode;
                if AfkCurrency.Get(AfkCurrCode) then
                    AfkCurrencyName := AfkCurrency.Description;

                if (AfkLocalCurrency.Get(GLSetup."LCY Code")) then
                    AfkLocalCurrencyName := AfkLocalCurrency.Description;





                //CalcFields("Work Description");
                //ShowWorkDescription := "Work Description".HasValue;
                TextApercu := ApercuLbl;

                //*************************************************************SALES HEADER***********************
                AfkLieuAdresseFacturation := StrSubstNo(AfkDateLieuFacturationLbl, Format(Header."Document Date", 0, 4));
                if AfkBoat.Get(Header.Afk_Boat_Number) then;
                NumLigne := 0;


                if Country.get(Cust."Country/Region Code") then;
                AfkCompanyAddress1 := CompanyInfo.Name;
                AfkCompanyAddress2 := CompanyInfo.Address;
                AfkCompanyAddress3 := CompanyInfo.City;
                AfkCustomerAddress1 := Cust.Address;
                AfkCustomerAddress2 := Cust."Address 2" + ' ' + Cust."Post Code" + ' ' + Cust.City + ' ' + Country.Name;
                AfkCustomerAddress3 := Cust."E-Mail" + ' ' + Cust."Phone No.";

                BankAccount1 := CompanyInfo."Bank Name";
                BankAccount1 := CompanyInfo."Bank Branch No." + ' ' + CompanyInfo."Bank Account No.";


                FooterLabel02Text := StrSubstNo(FooterLabel02,
                    CompanyInfo."Stock Capital", CompanyInfo."Registration No."
                    , CompanyInfo."Trade Register", CompanyInfo."APE Code");
                //************************************************************************************


                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                FillLeftHeader;
                FillRightHeader;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                GetLineFeeNoteOnReportHist("No.");

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                CalcFields("Amount Including VAT");
                //RemainingAmount := GetRemainingAmount;
                if RemainingAmount = 0 then
                    RemainingAmountTxt := AlreadyPaidLbl
                else
                    if RemainingAmount <> "Amount Including VAT" then
                        RemainingAmountTxt := StrSubstNo(PartiallyPaidLbl, Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
                    else
                        RemainingAmountTxt := '';

                OnAfterGetSalesHeader(Header);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
                //if ("Order No." = '') and "Prepayment Invoice" then
                //    "Order No." := "Prepayment Order No.";
                AfkTotalAmountInclVAT_LCY := 0;
                AfkTotalAmount_LCY := 0;
                AfkTotalVAT_LCY := 0;//*************************************
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
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
                // group(Options)
                // {
                //     Caption = 'Options';
                //     field(LogInteraction; LogInteraction)
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Log Interaction';
                //         Enabled = LogInteractionEnable;
                //         ToolTip = 'Specifies that interactions with the contact are logged.';
                //     }
                //     field(DisplayAsmInformation; DisplayAssemblyInformation)
                //     {
                //         ApplicationArea = Assembly;
                //         Caption = 'Show Assembly Components';
                //         ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold. (Only possible for RDLC report layout.)';
                //     }
                //     field(DisplayShipmentInformation; DisplayShipmentInformation)
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Show Shipments';
                //         ToolTip = 'Specifies that shipments are shown on the document.';
                //     }
                //     field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Show Additional Fee Note';
                //         ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
                //     }
                // }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
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
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if Header.FindSet() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        AfkBoat: Record Afk_Boat;
        AfkSetup: Record AfkSetup;
        CompanyBankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        Country: Record "Country/Region";
        AfkCurrency: Record currency;
        AfkLocalCurrency: Record currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        // VATIdentifierLbl: Label 'VAT Identifier';
        // VATPercentageLbl: Label 'VAT %';
        // SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        // SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        // SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        // BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        // BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        // BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        GLSetup: Record "General Ledger Setup";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        VATClause: Record "VAT Clause";
        RepCheck: Report "Check";
        QRCodeMgt: Codeunit AfkQRCodeMgt;
        AutoFormat: Codeunit "Auto Format";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        Language: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        DisplayAdditionalFeeNote: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        FirstLineHasBeenOutput: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowShippingAddr: Boolean;
        ShowWorkDescription: Boolean;
        NumLigneText: Code[2];
        AfkCurrCode: Code[20];
        JobNo: Code[20];
        JobTaskNo: Code[20];
        AfkTotalAmount_LCY: Decimal;
        AfkTotalAmountInclVAT_LCY: Decimal;
        AfkTotalVAT_LCY: Decimal;
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        RemainingAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TotalSubTotal: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TransHeaderAmount: Decimal;
        VATAmountLCY: Decimal;
        VATBaseLCY: Decimal;
        WorkDescriptionInstream: InStream;
        AfkIsLine: Integer;
        AfkLinesNumber: Integer;
        CompanyLogoPosition: Integer;
        NumLigne: Integer;
        AfkAddresseFacturationClientLbl: Label 'Customer Address';
        AfkAddresseFacturationLbl: Label 'Invoice Address';
        AfkAgentFacturationLbl: Label 'Agent :';
        AfkArreteMontantLbl: Label 'Fixed and certifies this invoice for the sum of :';
        AfkBaseCaptionLbl: Label 'BASE';
        AfkCodeClientLbl: Label 'Customer No :';
        AfkCompanyAccountLbl: Label 'Account No:';
        AfkCompanyBanqueLbl: Label 'Bank :';
        AfkCompteAfrilandLbl: Label 'Afriland First Bank Account';
        AfkCondPaiementLbl: Label 'Payment terms :';
        AfkDateLieuFacturationLbl: Label 'Limbe on %1', Comment = '%1 is invoice date';
        AfkDeviseLbl: Label 'Currency :';
        AfkExClientLbl: Label 'Ex Client';
        AfkLigneNoLbl: Label 'No';
        AfkLignePrestationsLbl: Label 'SERVICES';
        AfkLignePULbl: Label 'UNIT PRICE';
        AfkLigneQteLbl: Label 'QTY';
        AfkLigneTotalHTLbl: Label 'TOTAL Excl. VAT';
        AfkLigneTotalTTCLbl: Label 'TOTAL Incl. VAT';
        AfkLigneTVALbl: Label 'VAT';
        AfkNomClientLbl: Label 'Customer Name :';
        AfkNomNavireLbl: Label 'Ship''s name :';
        AfkNumContribuableLbl: Label 'Taxpayer Number :';
        AfkObjectLbl: Label 'Object :';
        AfkRCCMLbl: Label 'Trade Register :';
        AfkTerminalLbl: Label 'Terminal :';
        AfkTotalHTCFALbl: Label 'Total Excl. VAT CFAF :';
        AfkTotalHTDeviseLbl: Label 'Total Excl. VAT :';
        AfkTotalTTCCFALbl: Label 'Total Incl. VAT CFAF :';
        AfkTotalTTCDeviseLbl: Label 'Total Incl. VAT :';
        AfkTypeNavireLbl: Label 'Type of ship :';
        AfkVAT1925Lbl: Label 'VAT 19.25% :';
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        ApercuLbl: Label 'PROFORMA';
        BankAccountLbl: Label 'Bank Account';
        BilledToLbl: Label 'Billed to';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        ClosingLbl: Label 'Sincerely';















        // SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        // CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';
        FromLbl: Label 'From';
        GreetingLbl: Label 'Hello';
        HomePageLbl: Label 'Home Page';
        // InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No';
        JobNoLbl2: Label 'Job No.';
        JobTaskDescLbl: Label 'Job Task Description';
        JobTaskNoLbl2: Label 'Job Task No.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        PaymentMethodDescLbl: Label 'Payment Method :';
        // LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        // LocalCurrencyLbl: Label 'Local Currency';
        // PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms :';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        QRCodeLbl: Label 'Invoice No : %1 Date : %2 Total Amount Incl VAT : %3';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        QuestionsLbl: Label 'Questions?';
        // PostedShipmentDateLbl: Label 'Shipment Date';
        // SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        // YourSalesInvoiceLbl: Label 'Your Invoice';
        // ShipmentLbl: Label 'Shipment';
        // ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        ThanksLbl: Label 'Thank You!';
        TotalLbl: Label 'Total';
        UnitLbl: Label 'Unit';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        // VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATBaseLbl: Label 'VAT Base';
        // VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        Afk_AmountInWords: Text;
        AfkCompanyAddress1: Text;
        AfkCompanyAddress2: Text;
        AfkCompanyAddress3: Text;
        AfkCurrencyName: Text;
        AfkCustomerAddress1: Text;
        AfkCustomerAddress2: Text;
        AfkCustomerAddress3: Text;
        AfkLocalCurrencyName: Text;
        BankAccount1: Text;
        BankAccount2: Text;
        ChecksPayableText: Text;
        ExchangeRateText: Text;
        FormattedLineAmount: Text;
        FormattedLineAmountTTC: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        LineDiscountPctText: Text;
        NoText: array[2] of Text;
        PaymentInstructionsTxt: Text;
        PmtDiscText: Text;
        QRCode: Text;
        RemainingAmountTxt: Text;
        TotalAmountExclInclVATTextValue: Text;
        VATClausesText: Text;
        WorkDescriptionLine: Text;
        TextApercu: Text[20];
        SalesPersonText: Text[30];
        AfkFormattedBase: Text[50];
        AfkFormattedNumber: Text[50];
        AfkFormattedTotalHT: Text[50];
        AfkFormattedTotalTTC: Text[50];
        AfkFormattedTotalVAT: Text[50];
        AfkFormattedVAT: Text[50];
        AfkLieuAdresseFacturation: Text[50];
        AfkLocalCurrencyCaption: Text[50];
        AfkTotalAmount_LCYCaption: Text[50];
        AfkTotalAmount_LCYText: Text[50];
        AfkTotalAmountInclVAT_LCYCaption: Text[50];
        AfkTotalAmountInclVAT_LCYText: Text[50];
        AfkTotalVAT_LCYCaption: Text[50];
        AfkTotalVAT_LCYText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        AfkLocalCurrencyText: Text[100];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        JobTaskDescription: Text[100];
        ShipToAddr: array[8] of Text[100];
        FooterLabel02Text: Text[250];

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure InitializeShipmentLine()
    var
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if Line.Type = Line.Type::" " then
            exit;

        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit;

        //ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.FindFirst() then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next() = 0 then begin
                    ShipmentLine.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete();
                    exit;
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit;
            end;
        end;
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(SalesInvoiceLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText, TotalAmountVAT, false, true, false);
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet() then begin
            repeat
                TempLineFeeNoteOnReportHist.Init();
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0;
        end else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet() then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll();

        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl, Header.GetCustomerVATRegistrationNumber);
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl, Header.GetCustomerGlobalLocationNumber);
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        //FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl, Cust.GetLegalEntityType);
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);

        OnAfterFillLeftHeader(LeftHeader, Header);
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DeleteAll();

        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl, CompanyInfo.GetRegistrationNumber);
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyBankAccount.Name);
        FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
        FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption(IBAN), CompanyBankAccount.IBAN);
        FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption("SWIFT Code"), CompanyBankAccount."SWIFT Code");
        //FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl, Header.GetPaymentReference);

        OnAfterFillRightHeader(RightHeader, Header);
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        //with SalesHeader do begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        //end;
    end;


    local procedure GetJobTaskDescription(JobNo: Code[20]; JobTaskNo: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", JobNo);
        JobTask.SetRange("Job Task No.", JobTaskNo);
        if JobTask.FindFirst() then
            exit(JobTask.Description);

        exit('');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillLeftHeader(var LeftHeader: Record "Name/Value Buffer"; SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillRightHeader(var RightHeader: Record "Name/Value Buffer"; SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(TRUE, FALSE)]
    local procedure OnAfterGetSalesHeader(SalesHeader: Record "Sales Header")
    begin
    end;

    local procedure ShowVATClause(VATClauseCode: Code[20]): Boolean
    begin
        if VATClauseCode = '' then
            exit(false);

        exit(true);
    end;


}

