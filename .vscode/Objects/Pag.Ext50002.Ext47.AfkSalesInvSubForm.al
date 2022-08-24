pageextension 50002 AfkSalesInvSubForm extends "Sales invoice subform"
{
    layout
    {
        addafter("Description")
        {
            field("Afk_Printed_Description"; Rec.Afk_Printed_Description)
            {
                ApplicationArea = Suite;
                ToolTip = 'Description displayed on the invoice';
            }
            field("Afk_Quantity1"; Rec.Afk_Quantity1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_1"; Rec.Afk_Unit_of_Measure_Code_1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Quantity2"; Rec.Afk_Quantity2)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_2"; Rec.Afk_Unit_of_Measure_Code_2)
            {
                ApplicationArea = Suite;
            }
        }
        addafter("Job No.")
        {
            field("Afk_Strip_On_Quay"; Rec.Afk_Strip_On_Quay)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Rail_Access"; Rec.Afk_Rail_Access)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Road_Access"; Rec.Afk_Road_Access)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Elect_Network"; Rec.Afk_Elect_Network)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Phone_Network"; Rec.Afk_Phone_Network)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Water_Network"; Rec.Afk_Water_Network)
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        addafter("SelectMultiItems")
        {
            action(AfkCalcLines)
            {
                ApplicationArea = All;
                Caption = 'Calculate lines';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'calculate amount on lines';

                trigger OnAction()
                var
                    PricingCalc: Codeunit AfkPortServiceInvMgt;
                begin
                    PricingCalc.CalcAllLines(Rec.GetSalesHeader());
                end;
            }
        }
    }
}