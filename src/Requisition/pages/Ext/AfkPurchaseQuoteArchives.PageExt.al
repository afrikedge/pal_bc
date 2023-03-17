pageextension 50020 AfkPurchaseQuoteArchives extends "Purchase Quote Archives"
{
    Caption = 'Purchase Requisition Archive List';
    layout
    {
        addlast(Control1)
        {
            field(Afk_ProcessingStatus; Rec.Afk_ProcessingStatus)
            {
                ApplicationArea = All;
                //ToolTip = 'Specifies the value of the Level field.';
            }
        }
    }
    actions
    {
        addafter("Ver&sion")
        {
            action(AfkPrintFollowUp)
            {
                ApplicationArea = All;
                Caption = 'Print Follow Up';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    AfkPurchaseFollowUp: Report AfkPurchaseFollowUp;
                begin
                    AfkPurchaseFollowUp.SetInitialValues(Rec."No.",
                        Rec.Afk_OrderNoCreated, Rec.Afk_OrderCreationDate,
                        Rec."Document Date", Rec.Afk_ReleaseDate);
                    AfkPurchaseFollowUp.Run();
                end;
            }
        }
    }
}
