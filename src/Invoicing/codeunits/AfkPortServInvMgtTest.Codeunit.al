codeunit 50001 AfkPortServInvMgtTest
{

    Subtype = Test;

    trigger OnRun()
    begin

    end;

    [Test]
    procedure Navire_TerminalTypeNavireDetaille_PrixCorrectRetourne()
    var
        foundPrice: Record Afk_Princing;
        boat: Record Afk_Boat;
    begin


        //Prepare
        PrepareSalesOrder(SalesHeader, SalesLine, 'CMR', 'LIMBE', 1500, 5000, 'Tanker', DMY2Date(4, 1, 2022));

        PriceLine.DeleteAll();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := 'LIMBE';
        PriceLine.BoatType := '';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 2500;
        PriceLine.Insert();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := '';
        PriceLine.BoatType := '';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 3000;
        PriceLine.Insert();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := 'LIMBE';
        PriceLine.BoatType := 'Tanker';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 3500;
        PriceLine.Insert();




        //Act
        UnitPriceFound := PricingMgt.FindUnitPrice(foundPrice, SalesLine, SalesHeader);

        //Verify
        if (not UnitPriceFound) then
            ERROR(ErrorText2);

        ExpectedUnitPrice := 3500;
        IF foundPrice."Unit Price" <> ExpectedUnitPrice THEN
            ERROR(ErrorText1, foundPrice."Unit Price", ExpectedUnitPrice);
    end;

    [Test]
    procedure Navire_DateExpiree_PrixCorrectRetourne()
    var
        foundPrice: Record Afk_Princing;
        boat: Record Afk_Boat;
    begin


        //Prepare
        PrepareSalesOrder(SalesHeader, SalesLine, 'CMR', 'LIMBE', 1500, 5000, 'Tanker', DMY2Date(4, 1, 2022));

        PriceLine.DeleteAll();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := 'LIMBE';
        PriceLine.BoatType := '';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 2500;
        PriceLine.Insert();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := '';
        PriceLine.BoatType := '';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 3000;
        PriceLine.Insert();

        PriceLine.Init();
        EntryNum := EntryNum + 1;
        PriceLine.EntryNo := EntryNum;
        PriceLine."Item No." := '1000';
        PriceLine.Terminal := 'LIMBE';
        PriceLine.BoatType := 'Tanker';
        PriceLine.Pavillon := 'CMR';
        PriceLine."Unit of Measure Code 1" := '';
        PriceLine."Unit Price" := 3500;
        PriceLine."Starting Date" := DMY2Date(8, 1, 2022);
        PriceLine.Insert();




        //Act
        UnitPriceFound := PricingMgt.FindUnitPrice(foundPrice, SalesLine, SalesHeader);

        //Verify
        if (not UnitPriceFound) then
            ERROR(ErrorText2);

        ExpectedUnitPrice := 2500;
        IF foundPrice."Unit Price" <> ExpectedUnitPrice THEN
            ERROR(ErrorText1, foundPrice."Unit Price", ExpectedUnitPrice);
    end;

    local procedure PrepareSalesOrder(VAR SalesH: Record "Sales Header"; VAR SalesL: Record "Sales Line";
        boatCountry: Code[10]; Terminal: Code[20]; boatVolume: Decimal; boatTJB: Decimal;
        boatType: Code[20]; docDate: Date)
    begin

        Boat.Init();
        Boat.OMI_Number := 'B' + FORMAT(RANDOM(10000));
        Boat.Pavillon := boatCountry;
        Boat.Volume := boatVolume;
        Boat.TJB := boatTJB;
        Boat.BoatType := boatType;
        Boat.Insert();

        SalesH.INIT;
        SalesH."Document Type" := SalesH."Document Type"::Invoice;
        SalesH."No." := 'S' + FORMAT(RANDOM(10000));
        SalesH."Sell-to Customer No." := '10000';
        SalesH."Bill-to Customer No." := '10000';
        SalesH."Document Date" := docDate;
        SalesH.Afk_Boat_Number := boat.OMI_Number;
        SalesH."Responsibility Center" := Terminal;
        SalesH.INSERT();


        SalesL.INIT;
        SalesL."Document No." := SalesH."No.";
        SalesL."Document Type" := SalesLine."Document Type"::Order;
        SalesL.Type := SalesLine.Type::Item;
        SalesL."No." := '1000';
        SalesL.INSERT;

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        PriceLine: Record Afk_Princing;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ExpectedUnitPrice: Decimal;
        Boat: Record Afk_Boat;
        ErrorText1: Label 'The unit price was  %1 not %2 as expected';
        ErrorText2: Label 'The unit price was not found';
        PricingMgt: Codeunit "AfkPortServiceInvMgt";
        Cust: Record Customer;
        PriceGroup: Record "Customer Price Group";
        Item: Record Item;
        EntryNum: Integer;
        UnitPriceFound: Boolean;
}