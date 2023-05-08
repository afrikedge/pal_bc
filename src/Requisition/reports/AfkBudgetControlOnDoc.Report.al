report 50010 AfkBudgetControlOnDoc
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'A priori control of commitments';
    DefaultLayout = RDLC;
    RDLCLayout = './src/requisition/reports/layouts/AfkBudgetControlOnDoc.rdlc';

    dataset
    {
        dataitem(PurchHeader; "Purchase Header")
        {
            //DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1));
            DataItemTableView = SORTING("Document Type", "No.");



            column(StructureValue; StructureValue)
            {
            }
            column(ProgrammeValue; ProgrammeValue)
            {
            }
            column(ActionValue; ActionValue)
            {
            }
            column(ActiviteValue; ActiviteValue)
            {
            }
            column(TacheValue; TacheValue)
            {
            }
            column(NatureValue; NatureValue)
            {
            }
            column(DateValue; DateValue)
            {
            }
            column(ObjectValue; ObjectValue)
            {
            }
            column(OpAmountValue; OpAmountValue)
            {
            }
            column(InitialBudgetValue; InitialBudgetValue)
            {
            }
            column(CumulConsoValue; CumulConsoValue)
            {
            }
            column(TransfertPlusValue; TransfertPlusValue)
            {
            }
            column(TransfertMoinsValue; TransfertMoinsValue)
            {
            }
            column(SoldeADateValue; SoldeADateValue)
            {
            }
            column(LblStructure; LblStructure)
            {
            }
            column(LblProgramme; LblProgramme)
            {
            }
            column(LblAction; LblAction)
            {
            }
            column(LblActivite; LblActivite)
            {
            }
            column(LblTache; LblTache)
            {
            }
            column(LblNature; LblNature)
            {
            }
            column(LblTitle; LblTitle)
            {
            }
            column(LblDirecteur; LblDirecteur)
            {
            }
            column(LblLigneBudgetaire; LblLigneBudgetaire)
            {
            }
            column(LblObjet; LblObjet)
            {
            }
            column(LblMontantOp; LblMontantOp)
            {
            }
            column(LblMontantBudgetInitial; LblMontantBudgetInitial)
            {
            }
            column(LblCumulConso; LblCumulConso)
            {
            }
            column(LblTransfertPlus; LblTransfertPlus)
            {
            }
            column(LblTransfertMoins; LblTransfertMoins)
            {
            }
            column(LblSoldeCompteADate; LblSoldeCompteADate)
            {
            }
            column(LblEngagementApprove; LblEngagementApprove)
            {
            }
            column(LblLeDirControleBud; LblLeDirControleBud)
            {
            }
            column(LblOpInitieeLe; LblOpInitieeLe)
            {
            }

            column(DocumentNo; PurchHeader."No.")
            {
            }
            column(FooterLabel01; FooterLabel01)
            {
            }
            column(FooterLabel02Text; FooterLabel02Text)
            {
            }
            column(FooterLabel03; FooterLabel03) { }
            column(AfkCompanyPicture; CompanyInformation.Picture)
            {
            }





            trigger OnAfterGetRecord()
            //tacheCode1: Code[20];
            //NatureCode1: Code[20];
            begin

                OrderDocDate := PurchHeader."Document Date";

                FillBudgetAndNatureCodes();

                ObjectValue := PurchHeader.Afk_Object;

                DateValue := PurchHeader."Document Date";
                if (PurchHeader."Document Date" = 0D) then DateValue := Today;

                PurchHeader.CalcFields(Amount);
                OpAmountValue := PurchHeader.Amount;

                InitialBudgetValue := CalcInitialBudget();
                CumulConsoValue := CalcMontantConsoAJour() - OpAmountValue;
                TransfertPlusValue := CalcBudgetPlus();
                TransfertMoinsValue := CalcBudgetMoins();
                SoldeADateValue := InitialBudgetValue + TransfertPlusValue - CalcBudgetMoins - CumulConsoValue;


            end;

            trigger OnPreDataItem()
            begin
                AddOnSetup.Get();
                AddOnSetup.Testfield("Budgeted G/L Account Filter");

                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                //'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
                FooterLabel02Text := StrSubstNo(FooterLabel02,
                    CompanyInformation."Stock Capital", CompanyInformation."Registration No."
                    , CompanyInformation."Trade Register", CompanyInformation."APE Code");

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        AddOnSetup: Record AfkSetup;
        CompanyInformation: Record "Company Information";
        DimValue: Record "Dimension Value";
        BudgetControl: Codeunit AfkBudgetControl;
        NatureCode: Code[20];
        StructureCode: Code[20];
        //NatureValue: Text;
        TaskCode: Code[20];
        DateValue: Date;
        OrderDocDate: Date;
        CumulConsoValue: Decimal;
        InitialBudgetValue: Decimal;
        OpAmountValue: Decimal;
        SoldeADateValue: Decimal;
        TransfertMoinsValue: Decimal;
        TransfertPlusValue: Decimal;

        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';
        LblAction: Label 'Action :';
        LblActivite: Label 'Activity :';
        LblCumulConso: Label 'Cumulative consumption to date : ';
        LblDirecteur: Label 'The Director of Management Control certifies that :';
        LblEngagementApprove: Label 'COMMITMENT APPROUVED';
        LblLeDirControleBud: Label 'THE DIRECTOR OF BUDGETARY CONTROL';
        LblLigneBudgetaire: Label 'the above-referenced budget line has sufficient credit';
        LblMontantBudgetInitial: Label 'Initial account amount ';
        LblMontantOp: Label 'Amount of the proposed transaction :';
        LblNature: Label 'Nature :';
        LblObjet: Label 'Of object';
        LblOpInitieeLe: Label 'For the operation initiated on ';
        LblProgramme: Label 'Program :';
        LblSoldeCompteADate: Label 'Account balance to date :';
        LblStructure: Label 'Structure :';
        LblTache: Label 'Task :';
        LblTitle: Label 'A PRIORI CONTROL OF COMMITMENTS';
        LblTransfertMoins: Label 'Transfers ( - ) :';
        LblTransfertPlus: Label 'Transfers ( + ) :';
        ActionValue: Text;
        ActiviteValue: Text;
        NatureValue: Text;
        ObjectValue: Text;
        ProgrammeValue: Text;
        StructureValue: Text;
        TacheValue: Text;

        FooterLabel02Text: Text[250];


    local procedure CalcInitialBudget(): Decimal
    begin
        exit(BudgetControl.GetBudgetAmount(NatureCode, TaskCode, StartOfYear(), EndOfYear(), 0));
    end;

    local procedure CalcBudgetPlus(): Decimal
    begin
        exit(BudgetControl.GetBudgetAmount(NatureCode, TaskCode, StartOfYear(), EndOfYear(), 1));
    end;

    local procedure CalcBudgetMoins(): Decimal
    begin
        exit(BudgetControl.GetBudgetAmount(NatureCode, TaskCode, StartOfYear(), EndOfYear(), 2));
    end;

    local procedure CalcMontantConsoAJour(): Decimal
    var
        Engage: Decimal;
        preEngage: Decimal;
        Realise: Decimal;
    begin
        preEngage := BudgetControl.GetPrecommitmentAmt(NatureCode, TaskCode, StartOfYear(), EndOfYear());
        Engage := BudgetControl.GetCommitmentAmt(NatureCode, TaskCode, StartOfYear(), EndOfYear());
        Realise := BudgetControl.GetRealizedAmt(NatureCode, TaskCode, StartOfYear(), EndOfYear());
        exit(preEngage + Engage + Realise);
    end;

    local procedure StartOfYear(): Date
    begin
        Exit(DMY2DATE(1, 1, DATE2DMY(OrderDocDate, 3)));
    end;

    local procedure EndOfYear(): Date
    begin
        Exit(DMY2DATE(31, 12, DATE2DMY(OrderDocDate, 3)));
    end;

    local procedure FillBudgetAndNatureCodes()
    var
        DimValue: Record "Dimension Value";
        ActionCode: Code[20];
        ActivityCode: Code[20];
        ProgrammCode: Code[20];
    begin

        PurchHeader.TestField("Shortcut Dimension 1 Code");
        PurchHeader.TestField("Shortcut Dimension 2 Code");

        NatureCode := PurchHeader."Shortcut Dimension 2 Code";
        TaskCode := PurchHeader."Shortcut Dimension 1 Code";

        ProgrammCode := CopyStr(TaskCode, 1, 1);
        ActionCode := CopyStr(TaskCode, 1, 2);
        ActivityCode := CopyStr(TaskCode, 1, 4);

        DimValue.Reset();
        DimValue.SetRange("Global Dimension No.", 1);
        DimValue.SetRange(Code, ProgrammCode);
        if DimValue.FindFirst() then begin
            ProgrammeValue := StrSubstNo('%1 - %2', ProgrammCode, DimValue.Name);
            FindStructure(DimValue);
        end;


        DimValue.Reset();
        DimValue.SetRange("Global Dimension No.", 1);
        DimValue.SetRange(Code, ActionCode);
        if DimValue.FindFirst() then begin
            ActionValue := StrSubstNo('%1 - %2', ActionCode, DimValue.Name);
            FindStructure(DimValue);
        end;


        DimValue.Reset();
        DimValue.SetRange("Global Dimension No.", 1);
        DimValue.SetRange(Code, ActivityCode);
        if DimValue.FindFirst() then begin
            ActiviteValue := StrSubstNo('%1 - %2', ActivityCode, DimValue.Name);
            FindStructure(DimValue);
        end;


        DimValue.Reset();
        DimValue.SetRange("Global Dimension No.", 1);
        DimValue.SetRange(Code, TaskCode);
        if DimValue.FindFirst() then begin
            TacheValue := StrSubstNo('%1 - %2', TaskCode, DimValue.Name);
            FindStructure(DimValue);
        end;


        DimValue.Reset();
        DimValue.SetRange("Global Dimension No.", 2);
        DimValue.SetRange(Code, NatureCode);
        if DimValue.FindFirst() then
            NatureValue := StrSubstNo('%1 - %2', NatureCode, DimValue.Name);
    end;

    local procedure FindStructure(var DimValue: Record "Dimension Value")
    begin
        StructureCode := DimValue.AfkBudgetStructure;

        DimValue.Reset();
        DimValue.SetRange(DimValue."Dimension Code", 'STRUCTURE');
        DimValue.SetRange(Code, StructureCode);
        if DimValue.FindFirst() then
            //StructureValue := StrSubstNo('%1 - %2', StructureCode, DimValue.Name);
            StructureValue := DimValue.Name;
    end;


}
