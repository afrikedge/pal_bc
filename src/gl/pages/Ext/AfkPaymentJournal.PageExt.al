pageextension 50027 AfkPaymentJournal extends "Payment Journal"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(Afk_Authorised; Rec.Afk_Authorised)
            {
                Caption = 'Authorised';
                ApplicationArea = Suite;

                trigger OnValidate()
                var
                begin
                    UserSetup.Get(UserId);

                    if (not UserSetup.Afk_CanUpdateAutoriseOnPayment) then
                        Error(Text000);

                    if (Rec.Afk_Authorised) then
                        Rec.TestField("External Document No.");

                end;
            }
            field(Afk_Beneficiary; Rec.Afk_Beneficiary)
            {
                ApplicationArea = Suite;
            }
            field(Afk_RIBAccount; Rec.Afk_RIBAccount)
            {
                ApplicationArea = Suite;
            }
            field(Afk_Domiciliation; Rec.Afk_Domiciliation)
            {
                ApplicationArea = Suite;
            }
        }
    }
    actions
    {
        addafter("Dimensions")
        {
            action(AfkPrintTransferOrder)
            {
                ApplicationArea = All;
                Caption = 'Print Transfer Order';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    LineFilter: Record "Gen. Journal Line";
                begin
                    LineFilter.SetRange("Document No.", Rec."Document No.");
                    REPORT.Run(REPORT::AfkTransferOrder, true, false, LineFilter);
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        Text000: Label 'You are not authorized to modify this field.';
}
