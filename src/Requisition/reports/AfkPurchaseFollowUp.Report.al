report 50003 AfkPurchaseFollowUp
{
    RDLCLayout = './src/requisition/reports/layouts/AfkPurchaseFollowUp.rdlc';
    ApplicationArea = All;
    Caption = 'Requisition follow up';
    UsageCategory = Documents;
    AllowScheduling = false;

    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;



    dataset
    {
        dataitem(QuoteHeader; "Purchase Header Archive")
        {
            DataItemTableView = sorting("No.") where("Document Type" = const("Quote"));
            //RequestFilterFields = "No.";

            column(PRNumber; QuoteHeader."No.")
            {
            }
            column(PRDate; QuoteHeader."Document Date")
            {
            }
            column(PRValidationDate; QuoteHeader.Afk_ReleaseDate)
            {
            }
            column(OrderCreationDate; QuoteHeader.Afk_OrderCreationDate)
            {
            }
            column(ReceptionDate; ReceptionDate)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(PaymentDate; PaymentDate)
            {
            }
            column(PRFollowUpLabel; PRFollowUpLabel)
            {
            }
            column(PRDateLabel; PRDateLabel)
            {
            }
            column(PRValidationDateLabel; PRValidationDateLabel)
            {
            }
            column(PROrderCreationDateLabel; PROrderCreationDateLabel)
            {
            }
            column(PRLastReceptionDateLabel; PRLastReceptionDateLabel)
            {
            }
            column(PRLastInvoiceDateLabel; PRLastInvoiceDateLabel)
            {
            }
            column(PRLastPaymentDateLabel; PRLastPaymentDateLabel)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(TitleText; TitleText)
            {
            }
            column(PRNoLabel; PRNoLabel)
            {
            }

            trigger OnPreDataItem()
            begin
                if (NoFilter <> '') then
                    QuoteHeader.SetFilter("No.", '%1', NoFilter);
            end;

            trigger OnAfterGetRecord()
            var
                AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;
            begin
                TitleText := StrSubstNo(TitleLabel, QuoteHeader."No.");

                ReceptionDate := 0D;
                InvoiceDate := 0D;
                PaymentDate := 0D;
                if (QuoteHeader.Afk_OrderNoCreated <> '') then
                    AfkPurchaseReqMgt.GetDocumentDates(QuoteHeader.Afk_OrderNoCreated, ReceptionDate, InvoiceDate, PaymentDate);

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
                    Caption = 'Options';
                    field(NoFilter; NoFilter)
                    {
                        Caption = 'No filter';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Purchase Header Archive"."No." where("Document Type" = const(Quote));

                    }
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
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
    end;

    procedure SetInitialValues(PRNumber1: Code[20]; OrderNo1: Code[20]; OrderCreationDate1: Date; PRDate1: Date; PRValidationDate1: Date)
    begin
        PRNumber := PRNumber1;
        OrderNo := OrderNo1;
        OrderCreationDate := OrderCreationDate1;
        PRDate := PRDate1;
        PRValidationDate := PRValidationDate1;
    end;

    var
        CompanyInfo: Record "Company Information";
        OrderNo: Code[20];
        PRNumber: Code[20];
        InvoiceDate: Date;
        OrderCreationDate: Date;
        PaymentDate: Date;
        PRDate: Date;
        PRValidationDate: Date;
        ReceptionDate: Date;
        PRDateLabel: Label 'Purchase Requisition Date';
        PRFollowUpLabel: Label 'Purchase Follow Up';
        PRLastInvoiceDateLabel: Label 'Last Invoice Date';
        PRLastPaymentDateLabel: Label 'Last Payment Date';
        PRLastReceptionDateLabel: Label 'Last Reception Date';
        PRNoLabel: Label 'No';
        PROrderCreationDateLabel: Label 'Purchase Order Creation Date';
        PRValidationDateLabel: Label 'Purchase Validation Date';
        TitleLabel: Label 'Purchase Requisition %1';
        TitleText: Text[50];
        NoFilter: Text[100];
}
