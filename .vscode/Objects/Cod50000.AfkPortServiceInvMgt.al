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
        priceInInvoiceCurr: Decimal;
        calcVal: Decimal;
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

        SetSalesLinePrices(sLine, sHeader);
        //if (sLine."Line No." > 0) then sLine.Modify();

    end;

    procedure CalcTotalLines(sHeader: Record "Sales Header")
    var
        salesL: Record "Sales Line";
        totalHT: Decimal;
        Item2: Record Item;
    begin
        salesL.Reset();
        salesL.SetRange("Document Type", sHeader."Document Type");
        salesL.SetRange("Document No.", sHeader."No.");
        if salesL.FindSet() then
            repeat
                if (salesL.Type = salesL.Type::Item) then begin
                    Item2.get(salesL."No.");
                    if ((Item2.Afk_Quantity1 <> 'TOTAL_HT') and (Item2.Afk_Quantity2 <> 'TOTAL_HT')) then
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
        num: Integer;
        boat: Record afk_Boat;
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
        Item1: Record Item;
        CalcParamValues: Codeunit AfkCalcValueParams;
        CurrExchRate: Record "Currency Exchange Rate";
}