tableextension 50001 AfkSalesLine extends "Sales Line"
{
    fields
    {
        field(50000; "Afk_Quantity1"; Decimal)
        {
            Caption = 'Base';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkPricingMgt.SetSalesLinePrices(Rec, GetSalesHeader());
            end;
        }
        field(50001; "Afk_Unit_of_Measure_Code_1"; Code[10])
        {
            Caption = 'Unit of Base';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkPricingMgt.SetSalesLinePrices(Rec, GetSalesHeader());
            end;
        }
        field(50002; "Afk_Quantity2"; Decimal)
        {
            Caption = 'Number';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkPricingMgt.SetSalesLinePrices(Rec, GetSalesHeader());
            end;
        }
        field(50003; "Afk_Unit_of_Measure_Code_2"; Code[10])
        {
            Caption = 'Unit of Number';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkPricingMgt.SetSalesLinePrices(Rec, GetSalesHeader());
            end;
        }
        field(50006; "Afk_Strip_On_Quay"; Boolean)
        {
            Caption = 'Dockside strip';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Strip_On_Quay, AfkSetup.Afk_Strip_On_Quay_Percent);
            end;
        }
        field(50007; "Afk_Road_Access"; Boolean)
        {
            Caption = 'Road access';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Road_Access, AfkSetup.Afk_Road_Access_Percent);
            end;
        }
        field(50008; "Afk_Water_Network"; Boolean)
        {
            Caption = 'Water Network';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Water_Network, AfkSetup.Afk_Water_Network_Percent);
            end;
        }
        field(50009; "Afk_Rail_Access"; Boolean)
        {
            Caption = 'Rail access';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Rail_Access, AfkSetup.Afk_Rail_Access_Percent);
            end;
        }
        field(50010; "Afk_Elect_Network"; Boolean)
        {
            Caption = 'Electricity Network';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Elect_Network, AfkSetup.Afk_Elect_Network_Percent);
            end;
        }
        field(50011; "Afk_Phone_Network"; Boolean)
        {
            Caption = 'Phone Network';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AfkSetup.Get();
                UpdateSalesPriceWithMajoration(Afk_Phone_Network, AfkSetup.Afk_Phone_Network_Percent);
            end;
        }
        field(50012; "Afk_Printed_Description"; Text[100])
        {
            Caption = 'Printed Description';
            DataClassification = CustomerContent;
        }
    }

    var
        AfkPricingMgt: Codeunit AfkPortServiceInvMgt;
        AfkSetup: Record AfkSetup;
        IncreaseUPWarning: Label 'The unit price will be increased by %1 % \ Do you want to continue ?';
        DecreaseUPWarning: Label 'The unit price increased of %1 % will be cancelled \ Do you want to continue ?';


    local procedure UpdateSalesPriceWithMajoration(ApplyMajoration: Boolean; MajorationPercentage: Decimal)
    var
        SalesHeader: Record "Sales Header";
        Currency: Record "Currency";
    begin
        SalesHeader := GetSalesHeader();
        if SalesHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            SalesHeader.TestField("Currency Factor");
            Currency.Get(SalesHeader."Currency Code");
        end;

        if (ApplyMajoration) then begin

            if (Confirm(StrSubstNo(IncreaseUPWarning, MajorationPercentage))) then begin
                Validate("Unit Price",
                            Round(
                                "Unit Price" * (1 + (MajorationPercentage / 100)),
                        Currency."Unit-Amount Rounding Precision"));
            end else
                Error('');

        end else begin

            if (Confirm(StrSubstNo(DecreaseUPWarning, MajorationPercentage))) then begin
                Validate("Unit Price",
                            Round(
                                "Unit Price" / (1 + (MajorationPercentage / 100)),
                        Currency."Unit-Amount Rounding Precision"));
            end else
                Error('');
            

        end;

    end;

}