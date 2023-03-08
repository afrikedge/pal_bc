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
                NewDueDate: Date;
            begin
                if (DateDepot = 0D) then Error(Text002);

                NewDueDate := CalcNewDueDate(Header."Payment Terms Code");

                if Confirm(StrSubstNo(Text003, NewDueDate)) then begin
                    Header.Validate("Due Date", NewDueDate);
                    Header.Modify();

                    if (CustEntry.Get(Header."Cust. Ledger Entry No.")) then begin
                        CustEntry.Validate("Due Date", NewDueDate);
                        CustEntry.Modify();
                    end;
                end;


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
                    field(DateDepot; DateDepot)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deposit Date';
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
        end;

    }
    var
        DateDepot: Date;
        Text001: Label 'the modification has been completed successfully';
        Text002: Label 'Please enter a value for the deposit date';
        Text003: Label 'The new Due Date will be %1. Do you want to continue ?';

    local procedure CalcNewDueDate(PaymentTermsCode: Code[10]): Date
    var
        PaymentTerms: Record "Payment Terms";
    begin
        IF (PaymentTermsCode <> '') THEN BEGIN

            PaymentTerms.GET(PaymentTermsCode);
            exit(CALCDATE(PaymentTerms."Due Date Calculation", DateDepot));

        END ELSE BEGIN

            exit(DateDepot);

        END;
    end;
}
