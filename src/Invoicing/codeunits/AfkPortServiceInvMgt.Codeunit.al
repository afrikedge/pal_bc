codeunit 50000 AfkPortServiceInvMgt
{
    trigger OnRun()
    begin

    end;

    procedure SetSalesLinePrices(var sLine: Record "Sales Line";
            sHeader: Record "Sales Header")
    var
        linePrice: Record Afk_Princing;
        priceFound: Boolean;
        calcVal: Decimal;
        priceInInvoiceCurr: Decimal;
    begin

        if (sLine."No." = '') then exit;
        if (not SpecificUnitPriceExists(sLine."No.")) then exit;

        priceFound := FindUnitPrice(linePrice, sLine, sHeader);

        if (not priceFound) then begin
            sLine.Validate("Unit Price", 0);
        end else begin

            priceInInvoiceCurr := linePrice."Unit Price";
            if (linePrice."Currency Code" <> '') then begin
                priceInInvoiceCurr := CurrExchRate.ExchangeAmtFCYToFCY(sHeader."Document Date",
                    linePrice."Currency Code",
                    sHeader."Currency Code",
                    linePrice."Unit Price");
            end;

            if (linePrice.QtyCalculation = linePrice.QtyCalculation::Qty1) then
                sLine.Validate(Quantity, sLine.Afk_Quantity1);
            if (linePrice.QtyCalculation = linePrice.QtyCalculation::Qty2) then
                sLine.Validate(Quantity, sLine.Afk_Quantity2);
            if (linePrice.QtyCalculation = linePrice.QtyCalculation::Qty1_x_Qty2) then
                sLine.Validate(Quantity, sLine.Afk_Quantity1 * sLine.Afk_Quantity2);
            if (linePrice.QtyCalculation = linePrice.QtyCalculation::FlatRate) then
                sLine.Validate(Quantity, 1);

            sLine.Validate("Unit price", priceInInvoiceCurr);
        end;

        if (sLine."Line No." > 0) then sLine.Modify();

    end;

    procedure SetSalesLineDefValues(var sLine: Record "Sales Line";
            sHeader: Record "Sales Header")
    var
        calcVal: Decimal;
    begin
        if (sLine."No." = '') then exit;
        if (sLine.Type <> sLine.Type::Item) then exit;
        Item1.Get(sLine."No.");

        if (sLine.Afk_Printed_Description = '') then
            sLine.Afk_Printed_Description := Item1."Description 2";

        if (Item1.Afk_Quantity1 <> '') then begin
            calcVal := CalcParamValues.GetParamValue(sHeader, sLine, Item1.Afk_Quantity1);
            sLine.Afk_Quantity1 := calcVal;
        end;

        if (Item1.Afk_Quantity2 <> '') then begin
            calcVal := CalcParamValues.GetParamValue(sHeader, sLine, Item1.Afk_Quantity2);
            sLine.Afk_Quantity2 := calcVal;
        end;

        sLine.Afk_Unit_of_Measure_Code_1 := Item1.Afk_Unit_of_Measure_Code_1;
        sLine.Afk_Unit_of_Measure_Code_2 := Item1.Afk_Unit_of_Measure_Code_2;


        if (sLine."Line No." > 0) then sLine.Modify();
        SetSalesLinePrices(sLine, sHeader);
        //

    end;

    procedure CalcAllLines(sHeader: Record "Sales Header")
    var
        Item2: Record Item;
        salesL: Record "Sales Line";
        totalHT: Decimal;
    begin
        //Calcul lignes simples
        salesL.Reset();
        salesL.SetRange("Document Type", sHeader."Document Type");
        salesL.SetRange("Document No.", sHeader."No.");
        if salesL.FindSet() then
            repeat
                if (salesL.Type = salesL.Type::Item) then begin
                    if (not IsLigneTotalHT(salesL)) then begin
                        //salesL.Validate(salesL.Afk_Quantity1);
                        PortServMgt.SetSalesLineDefValues(salesL, sHeader);
                        //salesL.Modify();
                    end;
                end;
            until salesL.Next() < 1;

        //Calcul lignes de total
        CalcTotalLines(sHeader);
    end;


    procedure CalcTotalLines(sHeader: Record "Sales Header")
    var
        Item2: Record Item;
        salesL: Record "Sales Line";
        totalHT: Decimal;
    begin
        salesL.Reset();
        salesL.SetRange("Document Type", sHeader."Document Type");
        salesL.SetRange("Document No.", sHeader."No.");
        if salesL.FindSet() then
            repeat
                if (salesL.Type = salesL.Type::Item) then begin
                    if (not IsLigneTotalHT(salesL)) then
                        totalHT := totalHT + salesL."Line Amount";
                end else
                    totalHT := totalHT + salesL."Line Amount";

            until salesL.Next() < 1;


        salesL.Reset();
        salesL.SetRange("Document Type", sHeader."Document Type");
        salesL.SetRange("Document No.", sHeader."No.");
        if salesL.FindSet() then
            repeat
                if (salesL.Type = salesL.Type::Item) then begin
                    Item2.get(salesL."No.");

                    if ((Item2.Afk_Quantity1 = 'TOTAL_HT')) then begin
                        salesL.validate(Afk_Quantity1, totalht);
                        salesL.Modify();
                    end;

                    if ((Item2.Afk_Quantity2 = 'TOTAL_HT')) then begin
                        salesL.validate(Afk_Quantity2, totalht);
                        salesL.Modify();
                    end;
                end
            until salesL.Next() < 1;
    end;

    procedure LoadSalesInvoiceNosSeries(var SalesH: Record "Sales Header"; var xSalesH: Record "Sales Header"; var IsHandled: Boolean)
    var
        RespCenter: Record "Responsibility Center";
        UserSetup1: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetupMgt: Codeunit "User Setup Management";
        respCenterCode: Code[20];
    begin
        if (SalesH."Document Type" <> SalesH."Document Type"::Invoice) then
            exit;
        UserSetup1.get(UserId);
        UserSetup1.TestField("Sales Resp. Ctr. Filter");
        respCenterCode := UserSetupMgt.GetRespCenter(0, SalesH."Responsibility Center");
        RespCenter.get(RespCentercode);
        RespCenter.TestField(RespCenter.AfkSalesInvoiceNos);
        if SalesH."No." = '' then begin
            //SalesH.TestNoSeries;
            NoSeriesMgt.InitSeries(RespCenter.AfkSalesInvoiceNos, xSalesH."No. Series", SalesH."Posting Date", SalesH."No.", SalesH."No. Series");
            IsHandled := true;
        end;
    end;

    procedure LoadSalesInvoicePostingNosSeries(var SalesH: Record "Sales Header")
    var
        RespCenter: Record "Responsibility Center";
        UserSetup1: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetupMgt: Codeunit "User Setup Management";
        respCenterCode: Code[20];
    begin
        if (SalesH."Document Type" <> SalesH."Document Type"::Invoice) then
            exit;
        UserSetup1.get(UserId);

        respCenterCode := UserSetupMgt.GetRespCenter(0, SalesH."Responsibility Center");
        if (RespCenter.get(RespCentercode)) then begin
            RespCenter.TestField(RespCenter.AfkSalesInvoiceNos);
            SalesH."Posting No. Series" := RespCenter.AfkSalesInvoiceNos;
            if SalesH.Modify() then;
        end;
    end;

    procedure OnAfterValidate_RespCenter(var "Rec": Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        RespCenter: Record "Responsibility Center";
        UserSetup1: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetupMgt: Codeunit "User Setup Management";
        respCenterCode: Code[20];
    begin
        if (Rec."Responsibility Center" = xRec."Responsibility Center") then
            exit;

        respCenterCode := Rec."Responsibility Center";
        if (RespCenter.get(RespCentercode)) then begin
            RespCenter.TestField(RespCenter.AfkSalesInvoiceNos);
            Rec."Posting No. Series" := RespCenter.AfkSalesInvoiceNos;
            Rec."Posting No." := '';
        end;
    end;

    procedure InitSalesLineType(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesLine.Type := SalesLine.Type::Item;
        IsHandled := true;
    end;

    procedure InitSalesLineFromStandartLine(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    begin

        SalesLine.Afk_Printed_Description := StdSalesLine.Afk_Printed_Description;
        SalesLine.Afk_Unit_of_Measure_Code_1 := StdSalesLine.Afk_Unit_of_Measure_Code_1;
        SalesLine.Afk_Unit_of_Measure_Code_2 := StdSalesLine.Afk_Unit_of_Measure_Code_2;

        SalesLine.Afk_Elect_Network := StdSalesLine.Afk_Elect_Network;
        SalesLine.Afk_Phone_Network := StdSalesLine.Afk_Phone_Network;
        SalesLine.Afk_Strip_On_Quay := StdSalesLine.Afk_Strip_On_Quay;
        SalesLine.Afk_Road_Access := StdSalesLine.Afk_Road_Access;
        SalesLine.Afk_Rail_Access := StdSalesLine.Afk_Rail_Access;
        SalesLine.Afk_Water_Network := StdSalesLine.Afk_Water_Network;

        SalesLine.validate(Afk_Quantity1, StdSalesLine.Afk_Quantity1);
        SalesLine.validate(Afk_Quantity2, StdSalesLine.Afk_Quantity2);

    end;

    local procedure IsLigneTotalHT(salesL: Record "Sales Line"): Boolean
    var
        Item2: Record Item;
    begin

        if (salesL."No." = '') then exit(false);
        if (salesL.Type <> salesL.Type::Item) then exit(false);

        Item2.get(salesL."No.");
        exit((Item2.Afk_Quantity1 = 'TOTAL_HT') or (Item2.Afk_Quantity2 = 'TOTAL_HT'));
    end;

    local procedure SpecificUnitPriceExists(itemNo: Code[20]): Boolean
    var
        priceLine: Record Afk_Princing;

    begin
        priceLine.SetCurrentKey("Item No.", "Starting Date");
        priceLine.SetRange("Item No.", itemNo);
        exit(not priceLine.IsEmpty);
    end;

    procedure FindUnitPrice(var foundUpLine: Record Afk_Princing;
        sLine: Record "Sales Line";
        sHeader: Record "Sales Header"): Boolean
    var
        priceLine: Record Afk_Princing;
        maxMatches: Integer;
        nbMatches: Integer;
    begin

        maxMatches := -1;

        priceLine.SetCurrentKey("Item No.", "Starting Date");
        priceLine.SetRange("Item No.", sLine."No.");
        if priceLine.FindSet() then
            repeat
                nbMatches := GetNumberOfMatches(priceLine, sLine, sHeader);
                if (nbMatches >= 0) then begin
                    if (nbMatches >= maxMatches) then begin
                        maxMatches := nbMatches;
                        foundUpLine := priceLine;
                    end;
                end;
            until priceLine.Next() < 1;

        exit(maxMatches >= 0);
    end;

    local procedure GetNumberOfMatches(upLine: Record Afk_Princing;
        sLine: Record "Sales Line";
        sHeader: Record "Sales Header"): Integer
    var
        boat: Record afk_Boat;
        num: Integer;
    begin

        if (sLine."No." <> upLine."Item No.") then
            exit(-1);

        if IsMaching(upLine.Terminal, sHeader."Responsibility Center", num) = false then
            exit(-1);

        if (sHeader.Afk_Boat_Number <> '') then begin
            boat.Get(sHeader.Afk_Boat_Number);
            if IsMaching(upLine.BoatType, boat.BoatType, num) = false then
                exit(-1);

            if IsMaching(upLine.Pavillon, boat.Pavillon, num) = false then
                exit(-1);
        end;

        if IsMaching(upLine."Unit of Measure Code 1", sLine.Afk_Unit_of_Measure_Code_1, num) = false then
            exit(-1);

        if IsMaching(upLine."Unit of Measure Code 2", sLine.Afk_Unit_of_Measure_Code_2, num) = false then
            exit(-1);

        if IsMachingMinValue(upLine."Minimum Quantity 1", sLine.Afk_Quantity1) = false then
            exit(-1);

        if IsMachingMinValue(upLine."Minimum Quantity 2", sLine.Afk_Quantity2) = false then
            exit(-1);

        if IsMachingMaxValue(upLine."Maximum Quantity 1", sLine.Afk_Quantity1) = false then
            exit(-1);

        if IsMachingMaxValue(upLine."Maximum Quantity 2", sLine.Afk_Quantity2) = false then
            exit(-1);

        if IsMachingMinDate(upLine."Starting Date", sHeader."Document Date") = false then
            exit(-1);

        if IsMachingMaxDate(upLine."Ending Date", sHeader."Document Date") = false then
            exit(-1);


        exit(num);

    end;

    local procedure IsMaching(valueOnPriceLine: Text[50]; valueToCheck: Text[50]; var num: Integer): Boolean
    begin
        if (valueOnPriceLine = '') then begin
            exit(true);
        end
        else begin
            if (valueOnPriceLine = valueToCheck) then begin
                num := num + 1;
                exit(true);
            end
            else
                exit(false);
        end;
    end;

    local procedure IsMachingMinValue(minQty: Decimal; valueToCheck: Decimal): Boolean
    begin
        if (minQty > 0) then begin
            if (minQty > valueToCheck) then
                exit(false)
            else
                exit(true);
        end else
            exit(true);
    end;

    local procedure IsMachingMaxValue(maxQty: Decimal; valueToCheck: Decimal): Boolean
    begin
        if (maxQty > 0) then begin
            if (maxQty < valueToCheck) then
                exit(false)
            else
                exit(true);
        end else
            exit(true);
    end;

    local procedure IsMachingMinDate(startingDate: Date; valueToCheck: Date): Boolean
    begin
        if (startingDate > 0D) then begin
            if (startingDate > valueToCheck) then
                exit(false)
            else
                exit(true);
        end else
            exit(true);
    end;

    local procedure IsMachingMaxDate(endingDate: Date; valueToCheck: Date): Boolean
    begin
        if (endingDate > 0D) then begin
            if (endingDate < valueToCheck) then
                exit(false)
            else
                exit(true);
        end else
            exit(true);
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        Item1: Record Item;
        CalcParamValues: Codeunit AfkCalcValueParams;
        PortServMgt: Codeunit AfkPortServiceInvMgt;
}