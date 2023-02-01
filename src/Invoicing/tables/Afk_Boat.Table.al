table 50003 Afk_Boat
{
    DataClassification = CustomerContent;
    //DataClassification = ToBeClassified;
    DataCaptionFields = "OMI_Number", Name;
    DrillDownPageID = AfkBoatList;
    LookupPageID = "AfkBoatList";

    fields
    {
        field(1; OMI_Number; Code[30])
        {
            NotBlank = true;
            Caption = 'OMI Number';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Length"; Decimal)
        {
            Caption = 'Length (m)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(4; "Width"; Decimal)
        {
            Caption = 'Width (m)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(5; "Boat Draught"; Decimal)
        {
            Caption = 'Boat Draught (m)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(6; "Volume"; Decimal)
        {
            Caption = 'Volume (m3)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; "TJB"; Decimal)
        {
            Caption = 'TJB';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(8; "TJN"; Decimal)
        {
            Caption = 'TJN';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "Pavillon"; Code[10])
        {
            Caption = 'Pavillon';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(10; "Agent"; Code[20])
        {
            Caption = 'Agent';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(11; "BoatType"; Code[20])
        {
            NotBlank = true;
            Caption = 'Boat Type';
            TableRelation = "Afk_Generic_Type".Code where(RecordType = const(BoatType));
            DataClassification = CustomerContent;
        }
        field(20; NavigationType; Option)
        {
            Caption = 'Type of Navigation';
            OptionMembers = Cabotage,LongDistance;
            OptionCaption = 'Cabotage,Long Distance';
            DataClassification = CustomerContent;
        }
        field(21; Weight; Decimal)
        {
            Caption = 'Boat Weight (T)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(22; CallSign; Text[50])
        {
            Caption = 'Call Sign';
            DataClassification = CustomerContent;
        }
        field(23; ShipOwner; Text[50])
        {
            Caption = 'Armateur';
            DataClassification = CustomerContent;
        }
        field(24; MasterName; Text[50])
        {
            Caption = 'Master''s Name';
            DataClassification = CustomerContent;
        }
        field(25; TypeOfOperation; Option)
        {
            Caption = 'Type d''exploitation';
            OptionMembers = Liner,Tramp;
            OptionCaption = 'Liner,Tramp';
            DataClassification = CustomerContent;
        }
        field(26; "Calculated Boat Draught"; Decimal)
        {
            Caption = 'Calculated Boat Draught (m)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(27; Drivable; Boolean)
        {
            Caption = 'Drivable';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "OMI_Number")
        {
            Clustered = true;
        }
    }

    local procedure RefreshVolume()
    var
        finalTE: Decimal;
    begin
        "Calculated Boat Draught" := 0.14 * System.Power(Length * Width, 0.5);
        finalTE := "Boat Draught";
        if ("Calculated Boat Draught" > "Boat Draught") then
            finalTE := "Calculated Boat Draught";
        Volume := Length * Width * finalTE;
    end;

}