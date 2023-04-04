report 50009 AfkBudgetControl
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Budget Control';
    DefaultLayout = RDLC;
    RDLCLayout = './src/requisition/reports/layouts/AfkBudgetControl.rdlc';

    dataset
    {
        dataitem(Commandes; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

            column(OrderNo; OrderNo)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(OrderAmount; OrderAmount)
            {
            }
            column(CumulativeAmount; CumulativeAmount)
            {
            }
            column(Supplier; Supplier)
            {
            }
            column(AvailableAmount; AvailableAmount)
            {
            }
            column(OrderPurpose; OrderPurpose)
            {
            }
            column(DateDeb; DateDeb)
            {
            }
            column(DateFin; DateFin)
            {
            }
            column(InitialBudget; InitialBudget)
            {
            }
            column(FooterLabel01; FooterLabel01)
            {
            }
            column(FooterLabel02Text; FooterLabel02Text)
            {
            }
            column(FooterLabel03; FooterLabel03)
            {
            }
            column(TaskCode; TaskCode)
            {
            }
            column(NatureCode; NatureCode)
            {
            }
            column(TaskName; TaskName)
            {
            }
            column(NatureName; NatureName)
            {
            }


            column(LblAmount; LblAmount)
            {
            }
            column(LblAvailableAmount; LblAvailableAmount)
            {
            }
            column(LblCumulativeAmount; LblCumulativeAmount)
            {
            }
            column(LblDate; LblDate)
            {
            }
            column(LblExpenditure; LblExpenditure)
            {
            }
            column(LblHeadNo; LblHeadNo)
            {
            }
            column(LblInitialBudget; LblInitialBudget)
            {
            }
            column(LblPeriod; LblPeriod)
            {
            }
            column(LblPONumber; LblPONumber)
            {
            }
            column(LblPurpose; LblPurpose)
            {
            }
            column(LblSubHead; LblSubHead)
            {
            }
            column(LblSupplier; LblSupplier)
            {
            }
            column(LblTitle; LblTitle)
            {
            }
            column(LblBudgetaryHead; LblBudgetaryHead)
            {
            }
            column(AfkCompanyPicture; CompanyInformation.Picture)
            {
            }
            column(TxtPeriod; TxtPeriod)
            {
            }






            trigger OnAfterGetRecord()
            var
                PurchOrder: Record "Purchase Header";
                PurchOrderArchive: Record "Purchase Header Archive";
            begin


                if Number = OrderDatesListLength + 1 then
                    CurrReport.Break();



                OrderNo := OrderNosList[Number];
                if (PurchOrder.get(PurchOrder."Document Type"::Order, OrderNo)) then begin
                    OrderDate := PurchOrder."Order Date";
                    PurchOrder.CalcFields(Amount);
                    OrderAmount := PurchOrder.Amount;
                    CumulativeAmount := CumulativeAmount + OrderAmount;
                    AvailableAmount := InitialBudget - CumulativeAmount;
                    Supplier := PurchOrder."Buy-from Vendor Name";
                    OrderPurpose := PurchOrder.Afk_Object;
                end else begin
                    PurchOrderArchive.Reset();
                    PurchOrderArchive.SetRange("Document Type", PurchOrderArchive."Document Type"::Order);
                    PurchOrderArchive.SetRange(PurchOrderArchive."No.", OrderNo);
                    if PurchOrderArchive.FindFirst() then begin
                        OrderDate := PurchOrderArchive."Order Date";
                        PurchOrderArchive.CalcFields(Amount);
                        OrderAmount := PurchOrderArchive.Amount;
                        CumulativeAmount := CumulativeAmount + OrderAmount;
                        AvailableAmount := InitialBudget - CumulativeAmount;
                        Supplier := PurchOrderArchive."Buy-from Vendor Name";
                        OrderPurpose := PurchOrderArchive.Afk_Object;
                    end;
                end;





            end;

            trigger OnPreDataItem()
            begin
                AddOnSetup.Get();
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                //'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
                FooterLabel02Text := StrSubstNo(FooterLabel02,
                    CompanyInformation."Stock Capital", CompanyInformation."Registration No."
                    , CompanyInformation."Trade Register", CompanyInformation."APE Code");

                DimValue.Reset();
                DimValue.SetRange("Global Dimension No.", 1);
                DimValue.SetRange(Code, TaskCode);
                DimValue.FindFirst();
                TaskName := DimValue.Name;

                DimValue.Reset();
                DimValue.SetRange("Global Dimension No.", 2);
                DimValue.SetRange(Code, NatureCode);
                DimValue.FindFirst();
                NatureName := DimValue.Name;

                TxtPeriod := StrSubstNo('%1..%2', DateDeb, DateFin);

                InitialBudget := CalcInitialBudget();
                PrepareLists();
                SortLists();
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(TaskCode; TaskCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Head No :';
                        ToolTip = 'Code of the task';
                        ShowMandatory = true;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field(NatureCode; NatureCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Sub-Head No :';
                        ToolTip = 'Code of the Expenditure';
                        ShowMandatory = true;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin

                        end;
                    }
                    field(DateDeb; DateDeb)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date :';
                        ShowMandatory = true;
                    }
                    field(DateFin; DateFin)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date :';
                        ShowMandatory = true;
                    }
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
        NatureCode: Code[20];
        OrderNo: Code[20];
        OrderNosList: array[500] of Code[20];
        TaskCode: Code[20];
        DateDeb: Date;
        DateFin: Date;
        OrderDate: Date;
        //OrderDatesList: List of [Date];
        OrderDatesList: array[500] of Date;
        AvailableAmount: Decimal;
        CumulativeAmount: Decimal;
        InitialBudget: Decimal;
        OrderAmount: Decimal;

        OrderDatesListLength: Integer;
        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';
        LblAmount: Label 'AMOUNT';
        LblAvailableAmount: Label 'AVAILABLE AMOUNT';
        LblBudgetaryHead: Label 'Budgetary Head :';
        LblCumulativeAmount: Label 'CUMULATIVE AMOUNT';
        LblDate: Label 'DATE';
        LblExpenditure: Label 'Expenditure :';
        LblHeadNo: Label 'Head No :';
        LblInitialBudget: Label 'Project Budget :';
        LblPeriod: Label 'PERIOD :';
        LblPONumber: Label 'PURCHASE ORDER NO.';
        LblPurpose: Label 'PURPOSE OF EXPENDITURE';
        LblSubHead: Label 'Sub-Head No :';
        LblSupplier: Label 'SUPPLIER';
        LblTitle: Label 'BUDGET CONTROL AND FOLLOW-UP SHEET';
        NatureName: Text;
        OrderPurpose: Text;
        TaskName: Text;
        TxtPeriod: Text;
        Supplier: Text[100];
        FooterLabel02Text: Text[250];



    local procedure PrepareLists()
    var
        PurchOrder: Record "Purchase Header";
        PurchOrderArchive: Record "Purchase Header Archive";
        i: Integer;
    //PurchaseInvoice: Record "Purchase Header Archive";
    begin
        OrderDatesListLength := 0;
        i := 1;


        PurchOrder.Reset();
        PurchOrder.SetRange(PurchOrder."Document Type", PurchOrder."Document Type"::Order);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 1 Code", TaskCode);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 2 Code", NatureCode);
        PurchOrder.SETFILTER(PurchOrder."Order Date", '%1..%2', DateDeb, DateFin);
        if PurchOrder.FindSet() then
            repeat
                OrderDatesList[i] := PurchOrder."Order Date";
                OrderNosList[i] := PurchOrder."No.";
                OrderDatesListLength := OrderDatesListLength + 1;
                i := i + 1;
            until PurchOrder.Next() = 0;

        PurchOrderArchive.Reset();
        PurchOrderArchive.SetRange("Document Type", PurchOrder."Document Type"::Order);
        PurchOrderArchive.SetRange("Shortcut Dimension 1 Code", TaskCode);
        PurchOrderArchive.SetRange("Shortcut Dimension 2 Code", NatureCode);
        PurchOrderArchive.SETFILTER("Order Date", '%1..%2', DateDeb, DateFin);
        if PurchOrderArchive.FindSet() then
            repeat
                if (ValueExistsInList(PurchOrderArchive."No.") = false) then begin
                    OrderDatesList[i] := PurchOrderArchive."Order Date";
                    OrderNosList[i] := PurchOrderArchive."No.";
                    OrderDatesListLength := OrderDatesListLength + 1;
                    i := i + 1;
                end;
            until PurchOrderArchive.Next() = 0;

    end;

    local procedure CalcInitialBudget(): Decimal
    var
        BudgetLine: Record AfkDocRequisitionBudget;
    begin
        BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', TaskCode);
        BudgetLine.SETFILTER("Global Dimension 2 Filter", '%1', NatureCode);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Budgeted Amount");
        exit(BudgetLine."Budgeted Amount");
    end;

    local procedure ValueExistsInList(OrderNo1: Code[20]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to OrderDatesListLength do begin
            if (OrderNosList[i] = OrderNo1) then exit(true);
        end;
    end;

    local procedure SortLists()
    var
        itemMoved: Boolean;
        lowerValue2: Code[20];
        lowerValue: Date;
        i: Integer;
    begin
        itemMoved := false;
        repeat
            itemMoved := false;
            for i := 1 to OrderDatesListLength - 1 do begin
                if (OrderDatesList[i] > OrderDatesList[i + 1]) then begin

                    lowerValue := OrderDatesList[i + 1];
                    OrderDatesList[i + 1] := OrderDatesList[i];
                    OrderDatesList[i] := lowerValue;

                    lowerValue2 := OrderNosList[i + 1];
                    OrderNosList[i + 1] := OrderNosList[i];
                    OrderNosList[i] := lowerValue2;

                    itemMoved := true;
                end;
            end;
        until itemMoved = false;
    end;
}
