table 50001 Afk_Princing
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "EntryNo"; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
            trigger OnValidate()
            var
            begin
                if (Item1.Get("Item No.")) then begin
                    "Unit of Measure Code 1" := Item1.Afk_Unit_of_Measure_Code_1;
                    "Unit of Measure Code 2" := Item1.Afk_Unit_of_Measure_Code_2;
                end;
            end;
        }
        field(3; "Terminal"; Code[10])
        {
            Caption = 'Terminal';
            TableRelation = "Responsibility Center";
        }
        field(4; "BoatType"; Code[20])
        {
            Caption = 'Boat Type';
            TableRelation = "Afk_Generic_Type" where(RecordType = const(BoatType));
        }
        field(5; "Pavillon"; Code[10])
        {
            Caption = 'Pavillon';
            TableRelation = "Country/Region";
        }
        field(6; "Notes"; Text[100])
        {
            Caption = 'Notes';
        }
        field(8; "Unit of Measure Code 1"; Code[10])
        {
            Caption = 'Unit of Base';
            TableRelation = "Unit of Measure".Code;
        }
        field(9; "Minimum Quantity 1"; Decimal)
        {
            Caption = 'Minimum Base';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(10; "Maximum Quantity 1"; Decimal)
        {
            Caption = 'Maximum Base';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5400; "Unit of Measure Code 2"; Code[10])
        {
            Caption = 'Unit of Number,';
            TableRelation = "Unit of Measure".Code;
        }
        field(12; "Minimum Quantity 2"; Decimal)
        {
            Caption = 'Minimum Number';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(13; "Maximum Quantity 2"; Decimal)
        {
            Caption = 'Maximum Number';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }

        field(14; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
        }
        field(15; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(16; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';
        }

        field(17; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
                    Error(Text000, FieldCaption("Starting Date"), FieldCaption("Ending Date"));

            end;
        }
        field(18; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                Validate("Starting Date");
            end;
        }
        field(19; "Majoration"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Majoration';
        }
        field(20; QtyCalculation; Option)
        {
            Caption = 'Qty Calculation Mode';
            OptionMembers = Qty1,Qty1_x_Qty2,Qty2,FlatRate;
            OptionCaption = 'Base,Base x Number,Number,Flat Rate';
        }
        field(21; "Service Name"; Text[100])
        {
            Caption = 'Service Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }

    }

    keys
    {
        key(PK; "EntryNo")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Starting Date")
        {
        }
    }
    var
        Text000: Label '%1 cannot be after %2';
        Item1: Record Item;
}