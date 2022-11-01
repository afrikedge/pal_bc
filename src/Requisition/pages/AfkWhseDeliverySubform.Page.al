page 50015 AfkWhseDeliverySubForm
{
    Caption = 'WhseDeliverySubForm';
    PageType = ListPart;
    SourceTable = AfkWhseDeliveryLine;

    layout
    {

        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Type"; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    //Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Purchase Account"; Rec."Purchase Account")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Whse Quantity To Deliver"; Rec."Whse Quantity To Deliver")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Whse Delivered Quantity"; Rec."Whse Delivered Quantity")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }
}
