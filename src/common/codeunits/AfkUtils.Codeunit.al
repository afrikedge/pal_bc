codeunit 50016 AfkUtils
{
    internal procedure GetPageFooterInfos(var FootText: array[3] of Text)
    var
        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';
        FooterLabel02Text: Text[250];
    begin
        CompanyInfo.Get();

        FooterLabel02Text := StrSubstNo(FooterLabel02,
                    CompanyInfo."Stock Capital", CompanyInfo."Registration No."
                    , CompanyInfo."Trade Register", CompanyInfo."APE Code");

        FootText[1] := FooterLabel01;
        FootText[2] := FooterLabel02Text;
        FootText[3] := FooterLabel03;
    end;

    var
        CompanyInfo: Record "Company Information";
}
