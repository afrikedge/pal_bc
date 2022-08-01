table 50003 Afk_Boat
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; OMI_Number; Code[30])
        {
            NotBlank = true;
            Caption = 'OMI Number';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Length"; Decimal)
        {
            Caption = 'Length (m)';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(4; "Width"; Decimal)
        {
            Caption = 'Width (m)';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(5; "Boat Draught"; Decimal)
        {
            Caption = 'Boat Draught (m)';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                RefreshVolume();
            end;
        }
        field(6; "Volume"; Decimal)
        {
            Caption = 'Volume (m3)';
            DecimalPlaces = 0 : 5;
        }
        field(7; "TJB"; Decimal)
        {
            Caption = 'TJB';
            DecimalPlaces = 0 : 5;
        }
        field(8; "TJN"; Decimal)
        {
            Caption = 'TJN';
            DecimalPlaces = 0 : 5;
        }
        field(9; "Pavillon"; Code[10])
        {
            Caption = 'Pavillon';
            TableRelation = "Country/Region";
        }
        field(10; "Agent"; Code[20])
        {
            Caption = 'Agent';
            TableRelation = Customer;
        }
        field(11; "BoatType"; Code[20])
        {
            NotBlank = true;
            Caption = 'Boat Type';
            TableRelation = "Afk_Generic_Type".Code where(RecordType = const(BoatType));
        }
        field(20; NavigationType; Option)
        {
            Caption = 'Navigation Type';
            OptionMembers = Cabotage,LongDistance;
            OptionCaption = 'Cabotage,Long Distance';
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
    begin
        Volume := Length*Width*"Boat Draught";
    end;

}