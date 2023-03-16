report 50008 AfkSetSalesInvoiceDueDate
{
    Caption = 'Update Deposit Date';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            var
                CustEntry: record "Cust. Ledger Entry";
            //NewDueDate: Date;
            begin
                if (DateDepot = 0D) then Error(Text002);

                //NewDueDate := CalcNewDueDate(Header."Payment Terms Code");

                //if Confirm(StrSubstNo(Text003, NewDueDate)) then begin
                Header.Validate("Due Date", NvelleDateEcheance);
                Header.Modify();

                if (CustEntry.Get(Header."Cust. Ledger Entry No.")) then begin
                    CustEntry.Validate("Due Date", NvelleDateEcheance);
                    CustEntry.Modify();
                end;
                //end;


            end;

            trigger OnPostDataItem()
            begin
                //Message(Text001);
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
                    field(NumeroFacture; NumeroFacture)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Numéro facture';
                        Editable = false;

                    }
                    field(DateDepot; DateDepot)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deposit Date';
                        trigger OnValidate()
                        begin
                            if (DateDepot = 0D) then Error(Text002);
                            NvelleDateEcheance := CalcNewDueDate(InvoiceH."Payment Terms Code");
                        end;
                    }
                    field(FormuleCalcul; FormuleCalcul)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Calculation Formula';
                        Editable = false;
                    }
                    field(NvelleDateEcheance; NvelleDateEcheance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Due Date';
                        Editable = false;
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
        trigger OnOpenPage()
        begin
            DateDepot := WorkDate;

            NumeroFacture := Header.GetFilter(Header."No.");

            InvoiceH.get(NumeroFacture);
            NvelleDateEcheance := CalcNewDueDate(InvoiceH."Payment Terms Code");


        end;

    }
    var
        InvoiceH: Record "Sales Invoice Header";
        FormuleCalcul: DateFormula;
        NumeroFacture: code[20];
        DateDepot: Date;
        NvelleDateEcheance: Date;
        Text001: Label 'the modification has been completed successfully';
        Text002: Label 'Please enter a value for the deposit date';
        Text003: Label 'The new Due Date will be %1. Do you want to continue ?';

    local procedure CalcNewDueDate(PaymentTermsCode: Code[10]): Date
    var
        PaymentTerms: Record "Payment Terms";
    begin
        IF (PaymentTermsCode <> '') THEN BEGIN

            PaymentTerms.GET(PaymentTermsCode);
            FormuleCalcul := PaymentTerms."Due Date Calculation";
            exit(CALCDATE(PaymentTerms."Due Date Calculation", DateDepot));

        END ELSE BEGIN

            exit(DateDepot);

        END;
    end;
}
