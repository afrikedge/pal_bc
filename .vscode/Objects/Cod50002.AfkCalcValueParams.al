codeunit 50002 AfkCalcValueParams
{
    trigger OnRun()
    begin

    end;


    procedure GetParamValue(sHeader: Record "Sales Header"; sLine: Record "Sales Line"; paramCode: Code[20]): Decimal
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

    local procedure GetCalcParamValue(sHeader: Record "Sales Header"; sLine: Record "Sales Line"; paramCode: Code[20]): Decimal
    var
    begin

        if (paramCode = 'BOAT_VOLUME') then begin
            sHeader.TestField(Afk_Boat_Number);
            Boat.Get(sHeader.Afk_Boat_Number);
            exit(Boat.Volume);
        end;

        if (paramCode = 'BOAT_TJB') then begin
            sHeader.TestField(Afk_Boat_Number);
            Boat.Get(sHeader.Afk_Boat_Number);
            exit(Boat.TJB);
        end;

        if (paramCode = 'BOAT_TJN') then begin
            sHeader.TestField(Afk_Boat_Number);
            Boat.Get(sHeader.Afk_Boat_Number);
            exit(Boat.TJN);
        end;

        if (paramCode = 'NB_PASSENGERS') then begin
            sHeader.TestField(Afk_Boat_Number);
            exit(sHeader."Afk_Nb_National_Passengers" + sHeader."Afk_Nb_Foreign_Passengers");
        end;

        if (paramCode = 'NB_LOCAL_PASSENGERS') then begin
            sHeader.TestField(Afk_Boat_Number);
            exit(sHeader."Afk_Nb_National_Passengers");
        end;

        if (paramCode = 'NB_FOREIGN_PASSENGER') then begin
            sHeader.TestField(Afk_Boat_Number);
            exit(sHeader.Afk_Nb_Foreign_Passengers);
        end;

        exit(0);

    end;

    var
        Boat: Record Afk_Boat;
}