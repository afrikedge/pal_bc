pageextension 50001 AfkSalesInvoiceCard extends "Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Boat Informations")
            {
                field(Afk_Boat_Number; Rec.Afk_Boat_Number)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_TirantEau_Avant"; Rec.Afk_Arrival_TirantEau_Avant)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_TirantEau_Arr"; Rec.Afk_Arrival_TirantEau_Arr)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Date_Bouee"; Rec.Afk_Arrival_Date_Bouee)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Heure_Bouee"; Rec.Afk_Arrival_Heure_Bouee)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Pilot_Name"; Rec.Afk_Arrival_Pilot_Name)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Pilot_MAD_Date"; Rec.Afk_Arrival_Pilot_MAD_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Pilot_MAD_Time"; Rec.Afk_Arrival_Pilot_MAD_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Pilot_OnBoard_Date"; Rec.Afk_Arrival_Pilot_OnBoard_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Pilot_OnBoard_Time"; Rec.Afk_Arrival_Pilot_OnBoard_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Boat_Amarre_On"; Rec.Afk_Arrival_Boat_Amarre_On)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Boat_Amarre_Date"; Rec.Afk_Arrival_Boat_Amarre_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Arrival_Boat_Amarre_Time"; Rec.Afk_Arrival_Boat_Amarre_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Destination"; Rec.Afk_Depart_Destination)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_TirantEau_Avant"; Rec.Afk_Depart_TirantEau_Avant)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_TirantEau_Arr"; Rec.Afk_Depart_TirantEau_Arr)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Tonnage_Emb"; Rec.Afk_Depart_Tonnage_Emb)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Boat_Appareil_Date"; Rec.Afk_Depart_Boat_Appareil_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Boat_Appareil_Time"; Rec.Afk_Depart_Boat_Appareil_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Departure_Pilot_Name"; Rec.Afk_Departure_Pilot_Name)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Pilot_OnLoad_Date"; Rec.Afk_Depart_Pilot_OnLoad_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Pilot_OnLoad_Time"; Rec.Afk_Depart_Pilot_OnLoad_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Pilot_Return_Date"; Rec.Afk_Depart_Pilot_Return_Date)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Depart_Pilot_Return_Time"; Rec.Afk_Depart_Pilot_Return_Time)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Gross_Weight_OnBoard"; Rec.Afk_Gross_Weight_OnBoard)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Nb_Passengers"; Rec."Afk_Nb_National_Passengers")
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Nb_Foreign_Passengers"; Rec.Afk_Nb_Foreign_Passengers)
                {
                    ApplicationArea = Suite;
                }
            }
        }
    }

    actions
    {
        addafter("CopyDocument")
        {
            action(AfkCalcTotalLines)
            {
                ApplicationArea = All;
                Caption = 'Calculate total lines';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    PricingCalc: Codeunit AfkPortServiceInvMgt;
                begin
                    PricingCalc.CalcTotalLines(Rec);
                end;
            }
        }
    }
}