tableextension 50004 AfkRespCenter extends "Responsibility Center"
{
    fields
    {
        field(50000; "AfkSalesInvoiceNos"; Code[20])
        {
            Caption = 'Sales Invoice Nos.';
            TableRelation = "No. Series";
        }
    }

}