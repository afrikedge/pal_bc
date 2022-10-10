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
        dataitem(Integer; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 1));

            column(PRDate; PRDate)
            {
            }
            column(PRValidationDate; PRValidationDate)
            {
            }
            column(OrderCreationDate; OrderCreationDate)
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



            trigger OnAfterGetRecord()
            var
                AfkPurchaseReqMgt: Codeunit AfkPurchaseReqMgt;
            begin
                TitleText := StrSubstNo(TitleLabel, PRNumber);

                if (OrderNo <> '') then
                    AfkPurchaseReqMgt.GetDocumentDates(OrderNo, ReceptionDate, InvoiceDate, PaymentDate);

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
        PROrderCreationDateLabel: Label 'Purchase Order Creation Date';
        PRValidationDateLabel: Label 'Purchase Validation Date';
        TitleLabel: Label 'Purchase Requisition %1';
        TitleText: Text[50];
}
