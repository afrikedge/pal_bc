codeunit 50002 AfkCalcValueParams
{
    trigger OnRun()
    begin

    end;


    procedure GetParamValue(sHeader: Record "Sales Header"; sLine: Record "Sales Line"; paramCode: Code[30]): Decimal
    var
        paramRec: Record Afk_Calc_Parameter;
    begin

        paramRec.Get(paramCode);
        if (paramRec.DataType = paramRec.DataType::Fixe) then
            exit(paramRec.Value)
        else
            exit(GetCalcParamValue(sHeader, sLine, paramCode));
    end;

    procedure GetParamFixedValue(paramCode: Code[20]): Decimal
    var
        paramRec: Record Afk_Calc_Parameter;
    begin

        paramRec.Get(paramCode);
        if (paramRec.DataType = paramRec.DataType::Fixe) then
            exit(paramRec.Value);
        exit(0);
    end;

    local procedure GetCalcParamValue(sHeader: Record "Sales Header"; sLine: Record "Sales Line"; paramCode: Code[30]): Decimal
    var
        actualDate: DateTime;
        startDate: DateTime;
        nb: Integer;
        endDate: DateTime;
    begin

        if (paramCode = 'BOAT_VOLUME') then begin
            if Boat.Get(sHeader.Afk_Boat_Number) then;
            exit(Boat.Volume);
        end;

        if (paramCode = 'BOAT_TJB') then begin
            if Boat.Get(sHeader.Afk_Boat_Number) then;
            exit(Boat.TJB);
        end;

        if (paramCode = 'BOAT_TJN') then begin
            if Boat.Get(sHeader.Afk_Boat_Number) then;
            exit(Boat.TJN);
        end;

        if (paramCode = 'BOAT_WEIGHT') then begin
            if Boat.Get(sHeader.Afk_Boat_Number) then;
            exit(Boat.Weight);
        end;

        //Tonnage embarqué - départ
        if (paramCode = 'DEP_TONNAGE_EMBARQUE') then begin
            sHeader.TestField(Afk_Depart_Tonnage_Emb);
            exit(sHeader.Afk_Depart_Tonnage_Emb);
        end;

        //Tonnage débarqué - arrivée
        if (paramCode = 'ARR_TONNAGE_DEBARQUE') then begin
            sHeader.TestField("Afk_Arr_Tonnage_Debarque");
            exit(sHeader."Afk_Arr_Tonnage_Debarque");
        end;


        if (paramCode = 'NB_PASSENGERS') then begin
            sHeader.TestField(Afk_Boat_Number);
            exit(sHeader."Afk_Nb_National_Passengers" + sHeader."Afk_Nb_Foreign_Passengers");
        end;

        if (paramCode = 'NB_LOCAL_PASSENGERS') then begin
            exit(sHeader."Afk_Nb_National_Passengers");
        end;

        if (paramCode = 'NB_FOREIGN_PASSENGER') then begin
            exit(sHeader.Afk_Nb_Foreign_Passengers);
        end;

        if (paramCode = 'NBH_PILOT_ARR_DAY') then begin
            sHeader.TestField(Afk_Arrival_Boat_Amarre_Date);
            sHeader.TestField(Afk_Arrival_Boat_Amarre_Time);
            if ((not IsHoliDayDate(sHeader.Afk_Arrival_Boat_Amarre_Date))
            and (IsDuringDay(sHeader.Afk_Arrival_Boat_Amarre_Time))) then
                exit(1)
            else
                exit(0);
        end;

        if (paramCode = 'NBH_PILOT_DEP_DAY') then begin
            sHeader.TestField(Afk_Depart_Boat_Appareil_Date);
            sHeader.TestField(Afk_Depart_Boat_Appareil_Time);
            if ((not IsHoliDayDate(sHeader.Afk_Depart_Boat_Appareil_Date))
            and (IsDuringDay(sHeader.Afk_Depart_Boat_Appareil_Time))) then
                exit(1)
            else
                exit(0);
        end;

        if (paramCode = 'NBH_PILOT_ARR_HOLIDAY') then begin
            sHeader.TestField(Afk_Arrival_Boat_Amarre_Date);
            sHeader.TestField(Afk_Arrival_Boat_Amarre_Time);
            if ((IsHoliDayDate(sHeader.Afk_Arrival_Boat_Amarre_Date))
            or (IsDuringNight(sHeader.Afk_Arrival_Boat_Amarre_Time))) then
                exit(1)
            else
                exit(0);
        end;

        if (paramCode = 'NBH_PILOT_DEP_HOLIDAY') then begin
            sHeader.TestField(Afk_Depart_Boat_Appareil_Date);
            sHeader.TestField(Afk_Depart_Boat_Appareil_Time);
            if ((IsHoliDayDate(sHeader.Afk_Depart_Boat_Appareil_Date))
            or (IsDuringNight(sHeader.Afk_Depart_Boat_Appareil_Time))) then
                exit(1)
            else
                exit(0);
        end;

        if (paramCode = 'NBH_PILOT_ARR_WAITING_DAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Arrival_Pilot_MAD_Date);
            sHeader.TestField(Afk_Arrival_Pilot_MAD_Time);
            actualDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_MAD_Date, sHeader.Afk_Arrival_Pilot_MAD_Time);
            actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_OnBoard_Date, sHeader.Afk_Arrival_Pilot_OnBoard_time);
            while (actualDate < endDate) do begin
                if (not IsHoliDayDate(DT2Date(actualDate)) and IsDuringDay(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;

        if (paramCode = 'NBH_PILOT_ARR_WAITING_HOLIDAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Arrival_Pilot_MAD_Date);
            sHeader.TestField(Afk_Arrival_Pilot_MAD_Time);
            actualDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_MAD_Date, sHeader.Afk_Arrival_Pilot_MAD_Time);
            actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_OnBoard_Date, sHeader.Afk_Arrival_Pilot_OnBoard_time);
            while (actualDate < endDate) do begin
                if (IsHoliDayDate(DT2Date(actualDate)) or IsDuringNight(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;

        if (paramCode = 'NBH_PILOT_DEP_WAITING_DAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Depart_Pilot_OnLoad_Date);
            sHeader.TestField(Afk_Depart_Pilot_OnLoad_Time);
            actualDate := CreateDateTime(sHeader.Afk_Depart_Pilot_OnLoad_Date, sHeader.Afk_Depart_Pilot_OnLoad_Time);
            actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Depart_Pilot_Return_Date, sHeader.Afk_Depart_Pilot_Return_Time);
            while (actualDate < endDate) do begin
                if (not IsHoliDayDate(DT2Date(actualDate)) and IsDuringDay(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;

        if (paramCode = 'NBH_PILOT_DEP_WAITING_HOLIDAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Depart_Pilot_OnLoad_Date);
            sHeader.TestField(Afk_Depart_Pilot_OnLoad_Time);
            actualDate := CreateDateTime(sHeader.Afk_Depart_Pilot_OnLoad_Date, sHeader.Afk_Depart_Pilot_OnLoad_Time);
            actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Depart_Pilot_Return_Date, sHeader.Afk_Depart_Pilot_Return_Time);
            while (actualDate < endDate) do begin
                if (IsHoliDayDate(DT2Date(actualDate)) or IsDuringNight(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;


        //Temps de veille sécurité pilote (jour)
        if (paramCode = 'NBH_PILOT_SEC_VEILLE_DAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Arrival_Pilot_OnBoard_Date);
            sHeader.TestField(Afk_Arrival_Pilot_OnBoard_Time);
            sHeader.TestField(Afk_Depart_Pilot_Return_Date);
            sHeader.TestField(Afk_Depart_Pilot_Return_Time);
            actualDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_OnBoard_Date, sHeader.Afk_Arrival_Pilot_OnBoard_Time);
            //actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Depart_Pilot_OnLoad_Date, sHeader.Afk_Depart_Pilot_OnLoad_Time);
            while (actualDate < endDate) do begin
                if (not IsHoliDayDate(DT2Date(actualDate)) and IsDuringDay(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;

        if (paramCode = 'NBH_PILOT_SEC_VEILLE_HOLIDAY') then begin
            nb := 0;
            sHeader.TestField(Afk_Arrival_Pilot_OnBoard_Date);
            sHeader.TestField(Afk_Arrival_Pilot_OnBoard_Time);
            sHeader.TestField(Afk_Depart_Pilot_Return_Date);
            sHeader.TestField(Afk_Depart_Pilot_Return_Time);
            actualDate := CreateDateTime(sHeader.Afk_Arrival_Pilot_OnBoard_Date, sHeader.Afk_Arrival_Pilot_OnBoard_Time);
            //actualDate := actualDate + (1 * 60 * 60 * 1000);//add free hour
            endDate := CreateDateTime(sHeader.Afk_Depart_Pilot_OnLoad_Date, sHeader.Afk_Depart_Pilot_OnLoad_Time);
            while (actualDate < endDate) do begin
                if (IsHoliDayDate(DT2Date(actualDate)) or IsDuringNight(DT2Time(actualDate))) then
                    nb += 1;
                actualDate := actualDate + (1 * 60 * 60 * 1000);//add 1 hour
            end;
            exit(nb);
        end;







        exit(0);

    end;

    local procedure IsDuringDay(t: Time): Boolean
    var
        startDate: DateTime;
        endDate: DateTime;
        actual: DateTime;
    begin
        AfkSetup.Get();
        AfkSetup.TestField("Day starting time");
        AfkSetup.TestField("Night starting time");
        /*         startDate := CreateDateTime(Today, AfkSetup."Day starting time");
                endDate := CreateDateTime(Today, AfkSetup."Night starting time");
                actual := CreateDateTime(Today, t);
                exit((actual >= startDate) and (actual < endDate)); */

        if ((t >= AfkSetup."Day starting time") and (t < AfkSetup."Night starting time")) then
            exit(true);

    end;

    local procedure IsDuringNight(t: Time): Boolean
    var
        startDate: DateTime;
        endDate: DateTime;
        actual: DateTime;
        nextDay: Date;
    begin
        AfkSetup.Get();
        AfkSetup.TestField("Day starting time");
        AfkSetup.TestField("Night starting time");

        /*     startDate := CreateDateTime(Today, AfkSetup."Night starting time");
        nextDay := calcdate('<1D>', Today);
        endDate := CreateDateTime(nextDay, AfkSetup."Day starting time");
        actual := CreateDateTime(Today, t);
        exit((actual >= startDate) and (actual < endDate)); */

        if ((t >= 0T) and (t < AfkSetup."Day starting time")) then
            exit(true);
        if ((t >= AfkSetup."Night starting time") and (t <= 235959T)) then
            exit(true);


    end;

    local procedure IsHoliDayDate(d: Date): Boolean
    var
        CalendarMgmt: Codeunit "Calendar Management";
        CalChange: Record "Customized Calendar Change";
        actual: DateTime;
        nextDay: Date;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField("Base Calendar Code");
        CalendarMgmt.SetSource(CompanyInfo, CalChange);
        exit(CalendarMgmt.IsNonworkingDay(d, CalChange));
    end;

    var
        Boat: Record Afk_Boat;
        AfkSetup: Record 50004;
        CompanyInfo: Record "Company Information";
}