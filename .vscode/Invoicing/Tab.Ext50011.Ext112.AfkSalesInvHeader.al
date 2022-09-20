tableextension 50011 AfkSalesInvHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Afk_Boat_Number"; Code[20])
        {
            Caption = 'Boat Number';
            TableRelation = Afk_Boat.OMI_Number;
        }
        field(50001; "Afk_Arrival_TirantEau_Avant"; Decimal)
        {
            Caption = 'Arrival - Front Draught (m)';
            DecimalPlaces = 0 : 5;
        }
        field(50002; "Afk_Arrival_TirantEau_Arr"; Decimal)
        {
            Caption = 'Arrival - Aft Draught (m)';
            DecimalPlaces = 0 : 5;
        }
        field(50003; "Afk_Arrival_Date_Bouee"; Date)
        {
            Caption = 'Mooring buoy arrival date';
        }
        field(50004; "Afk_Arrival_Heure_Bouee"; Time)
        {
            Caption = 'Mooring buoy arrival time';
        }
        field(50005; Afk_Arrival_Pilot_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Arrival: Name of Pilot';
        }
        field(50006; "Afk_Arrival_Pilot_MAD_Date"; Date)
        {
            Caption = 'Arrival: Pilot made available date';
        }
        field(50007; "Afk_Arrival_Pilot_MAD_Time"; Time)
        {
            Caption = 'Arrival: Pilot made available time';
        }
        field(50008; "Afk_Arrival_Pilot_OnBoard_Date"; Date)
        {
            Caption = 'Arrival: Pilot on board date';
        }
        field(50009; "Afk_Arrival_Pilot_OnBoard_Time"; Time)
        {
            Caption = 'Arrival: Pilot on board time';
        }
        field(50010; "Afk_Arrival_Boat_Amarre_Date"; Date)
        {
            Caption = 'Arrival: Boat Mooring date';
        }
        field(50011; "Afk_Arrival_Boat_Amarre_Time"; Time)
        {
            Caption = 'Arrival: Boat Mooring time';
        }
        field(50012; "Afk_Arrival_Boat_Amarre_On"; Text[30])
        {
            //Quai d’amarrage du navire
            Caption = 'Boat Mooring Dock';
        }
        field(50013; "Afk_Depart_Destination"; Text[30])
        {
            //Quai d’amarrage du navire
            Caption = 'Departure Destination';
        }
        field(50014; "Afk_Depart_TirantEau_Avant"; Decimal)
        {
            Caption = 'Departure - Front Draught (m)';
            DecimalPlaces = 0 : 5;
        }
        field(50015; "Afk_Depart_TirantEau_Arr"; Decimal)
        {
            Caption = 'Departure - Aft Draught (m)';
            DecimalPlaces = 0 : 5;
        }
        field(50016; "Afk_Depart_Tonnage_Emb"; Decimal)
        {
            Caption = 'Departure: Tonnage embarked';
            DecimalPlaces = 0 : 5;
        }
        field(50017; "Afk_Depart_Boat_Appareil_Date"; Date)
        {
            Caption = 'Departure: Ship sailed date';
        }
        field(50018; "Afk_Depart_Boat_Appareil_Time"; Time)
        {
            Caption = 'Departure: Ship sailed time';
        }
        field(50019; Afk_Departure_Pilot_Name; Text[50])
        {
            Caption = 'Departure: Name of Pilot';
        }
        field(50020; "Afk_Depart_Pilot_OnLoad_Date"; Date)
        {
            Caption = 'Departure: Pilot disembarked date';
        }
        field(50021; "Afk_Depart_Pilot_OnLoad_Time"; Time)
        {
            Caption = 'Departure: Pilot disembarked time';
        }
        field(50022; "Afk_Depart_Pilot_Return_Date"; Date)
        {
            Caption = 'Departure: pilot return to the station date';
        }
        field(50023; "Afk_Depart_Pilot_Return_Time"; Time)
        {
            Caption = 'Departure: pilot return to the station time';
        }
        field(50024; "Afk_Arr_Tonnage_Debarque"; Decimal)
        {
            //Tonnage débarqué arrivée
            Caption = 'Arrival: Landed tonnage';
            DecimalPlaces = 0 : 5;
        }
        field(50025; "Afk_Nb_National_Passengers"; Integer)
        {
            Caption = 'Number of National passengers';
        }
        field(50026; "Afk_Nb_Foreign_Passengers"; Integer)
        {
            Caption = 'Number of Foreign passengers';
        }
        field(50027; "Afk_Invoice_Object"; Text[100])
        {
            Caption = 'Subject';
        }
        field(50028; "Piloting sheet number"; Text[50])
        {
            Caption = 'Piloting sheet number';
        }
    }

}