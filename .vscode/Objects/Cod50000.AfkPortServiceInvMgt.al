codeunit 50000 AfkPortServiceInvMgt
{
    trigger OnRun()
    begin

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

        priceLine.SetCurrentKey("Item No.","Starting Date");
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

        if IsMachingMinValue(upLine."Minimum Quantity 1", upLine."Minimum Quantity 1") = false then
            exit(-1);

        if IsMachingMinValue(upLine."Minimum Quantity 2", upLine."Minimum Quantity 2") = false then
            exit(-1);

        if IsMachingMaxValue(upLine."Maximum Quantity 1", upLine."Minimum Quantity 1") = false then
            exit(-1);

        if IsMachingMaxValue(upLine."Maximum Quantity 2", upLine."Minimum Quantity 2") = false then
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
        myInt: Integer;
}