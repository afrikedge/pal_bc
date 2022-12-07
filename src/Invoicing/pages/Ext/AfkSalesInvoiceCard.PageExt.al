pageextension 50001 AfkSalesInvoiceCard extends "Sales Invoice"
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("Afk_LanguageCode"; Rec."Language Code")
            {
                ApplicationArea = Suite;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field(Afk_Invoice_Object; Rec.Afk_Invoice_Object)
            {
                ApplicationArea = Suite;
                ToolTip = 'Invoice subject';
            }
        }
        addafter(General)
        {
            group("Afk_Boat_Informations")
            {
                Caption = 'Boat Informations';

                field(Afk_Boat_Number; Rec.Afk_Boat_Number)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Vessel concerned by the invoice';
                }
                field("Afk_PilotingSheetNumber"; Rec."Afk_PilotingSheetNumber")
                {
                    ApplicationArea = Suite;
                    //ToolTip = 'Invoice subject';
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
                    ToolTip = 'Pilot''s full name';
                }
                field("Afk_Arrival_Pilot_MAD_Date"; Rec.Afk_Arrival_Pilot_MAD_Date)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Pilot availability date';
                }
                field("Afk_Arrival_Pilot_MAD_Time"; Rec.Afk_Arrival_Pilot_MAD_Time)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Pilot availability time';
                }
                field("Afk_Arrival_Pilot_OnBoard_Date"; Rec.Afk_Arrival_Pilot_OnBoard_Date)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Date of arrival on board of the pilot';
                }
                field("Afk_Arrival_Pilot_OnBoard_Time"; Rec.Afk_Arrival_Pilot_OnBoard_Time)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Pilot arrival time on board';
                }
                field("Afk_Arrival_Boat_Amarre_On"; Rec.Afk_Arrival_Boat_Amarre_On)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Ship mooring dock';

                }
                field("Afk_Arrival_Boat_Amarre_Date"; Rec.Afk_Arrival_Boat_Amarre_Date)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Docking date of the ship';
                }
                field("Afk_Arrival_Boat_Amarre_Time"; Rec.Afk_Arrival_Boat_Amarre_Time)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Vessel docking time';
                }
                field("Afk_Arr_Tonnage_Debarque"; Rec."Afk_Arr_Tonnage_Debarque")
                {
                    //Tonnage débarque arrivee
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
                    ToolTip = 'Date of departure of the vessel';
                }
                field("Afk_Depart_Boat_Appareil_Time"; Rec.Afk_Depart_Boat_Appareil_Time)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Ship''s departure time';
                }
                field("Afk_Departure_Pilot_Name"; Rec.Afk_Departure_Pilot_Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Full name of the pilot at the departure of the boat';
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
                    ToolTip = 'Date of return of the pilot to the station';
                }
                field("Afk_Depart_Pilot_Return_Time"; Rec.Afk_Depart_Pilot_Return_Time)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Time of return of the pilot to the station';
                }

                field("Afk_Nb_Passengers"; Rec."Afk_Nb_National_Passengers")
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Nb_Foreign_Passengers"; Rec.Afk_Nb_Foreign_Passengers)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_CrewMembersNumber"; Rec.Afk_CrewMembersNumber)
                {
                    ApplicationArea = Suite;
                }

            }
        }
        modify("Salesperson Code")
        {
            Caption = 'Billing Agent';
        }
        modify("Responsibility Center")
        {
            Caption = 'Terminal';
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
            action(AfkPrintPreview)
            {
                ApplicationArea = All;
                Caption = 'Print Preview';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    SalesFilter: Record "Sales Header";
                begin
                    SalesFilter.SetRange("No.", Rec."No.");
                    REPORT.Run(REPORT::AfkSalesInvoicePreview, true, false, SalesFilter);
                end;
            }
        }
    }
}