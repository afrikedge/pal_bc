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
            column(DocStatus; DocStatus)
            {
            }
            column(LblDocStatus; LblDocStatus)
            {
            }






            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
                PurchInvoice: Record "Purch. Inv. Header";
                PurchOrder: Record "Purchase Header";
                PurchOrderArchive: Record "Purchase Header Archive";
                idType: Integer;
            begin


                if Number = OrderDatesListLength + 1 then
                    CurrReport.Break();



                OrderNo := OrderNosList[Number];
                idType := OrderTypeList[Number];

                if (idType = 0) then begin
                    if (PurchOrder.get(PurchOrder."Document Type"::Order, OrderNo)) then
                        FillLineOrder(PurchOrder, OrderDate, OrderAmount, CumulativeAmount,
                            AvailableAmount, Supplier, OrderPurpose);
                    DocStatus := LblEngage;
                end;

                /*
                    if (idType = 1) then begin
                        PurchOrderArchive.Reset();
                        PurchOrderArchive.SetRange("Document Type", PurchOrderArchive."Document Type"::Order);
                        PurchOrderArchive.SetRange(PurchOrderArchive."No.", OrderNo);
                        if PurchOrderArchive.FindFirst() then begin
                            FillLineArchiveOrder(PurchOrderArchive, OrderDate, OrderAmount, CumulativeAmount,
                                AvailableAmount, Supplier, OrderPurpose);
                        end;
                    end;
                */

                if (idType = 2) then begin//Demandes d'achat
                    if (PurchOrder.get(PurchOrder."Document Type"::Quote, OrderNo)) then
                        FillLineOrder(PurchOrder, OrderDate, OrderAmount, CumulativeAmount,
                            AvailableAmount, Supplier, OrderPurpose);
                    DocStatus := LblPreEngage;
                end;


                if (idType = 3) then begin//GL Entries
                    if (GLEntry.get(OrderNo)) then
                        FillLineInvoice(GLEntry, Orderno, OrderDate, OrderAmount, CumulativeAmount,
                            AvailableAmount, Supplier, OrderPurpose);
                    DocStatus := LblRealise;
                end;


                if (idType = 5) then begin//Facture d'achat directes
                    if (PurchOrder.get(PurchOrder."Document Type"::Invoice, OrderNo)) then
                        FillLineOrder(PurchOrder, OrderDate, OrderAmount, CumulativeAmount,
                            AvailableAmount, Supplier, OrderPurpose);
                    DocStatus := LblEngage;
                end;


                /*
                                if (idType = 3) then begin//Factures directes
                                    if (PurchInvoice.get(OrderNo)) then
                                        FillLineInvoice(PurchInvoice, OrderDate, OrderAmount, CumulativeAmount,
                                            AvailableAmount, Supplier, OrderPurpose);
                                end;

                                if (idType = 4) then begin//Avoir directes
                                    if (PurchCrMemo.get(OrderNo)) then
                                        FillLineCreditMemo(PurchCrMemo, OrderDate, OrderAmount, CumulativeAmount,
                                            AvailableAmount, Supplier, OrderPurpose);
                                end;
                                */


                // if (PurchOrder.get(PurchOrder."Document Type"::Order, OrderNo)) then begin
                //     FillLineOrder(PurchOrder, OrderDate, OrderAmount, CumulativeAmount, AvailableAmount, Supplier, OrderPurpose);
                // end else begin
                //     PurchOrderArchive.Reset();
                //     PurchOrderArchive.SetRange("Document Type", PurchOrderArchive."Document Type"::Order);
                //     PurchOrderArchive.SetRange(PurchOrderArchive."No.", OrderNo);
                //     if PurchOrderArchive.FindFirst() then begin
                //         OrderDate := PurchOrderArchive."Order Date";
                //         PurchOrderArchive.CalcFields(Amount);
                //         OrderAmount := PurchOrderArchive.Amount;
                //         CumulativeAmount := CumulativeAmount + OrderAmount;
                //         AvailableAmount := InitialBudget - CumulativeAmount;
                //         Supplier := PurchOrderArchive."Buy-from Vendor Name";
                //         OrderPurpose := PurchOrderArchive.Afk_Object;
                //     end;
                // end;





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
        OrderTypeList: array[500] of Integer;
        FooterLabel01: Label 'Pôle de Référence au cœur du golfe de Guinée | Pole of Reference at the Heart of the Gulf of Guinea';
        FooterLabel02: Label 'Société Anonyme à Capital Public | Capital social : %1 | N° Contribuable : %2 | RCCM : %3 | NACAM : %4';
        FooterLabel03: Label 'Port Authority of Limbe Transitional Administration P.O Box 456 Limbe';
        LblAmount: Label 'AMOUNT';
        LblAvailableAmount: Label 'AVAILABLE AMOUNT';
        LblBudgetaryHead: Label 'Budgetary Head :';
        LblCumulativeAmount: Label 'CUMULATIVE AMOUNT';
        LblDate: Label 'DATE';
        LblDocStatus: Label 'Statut';
        LblEngage: Label 'Commited';
        LblExpenditure: Label 'Expenditure :';
        LblHeadNo: Label 'Head No :';
        LblInitialBudget: Label 'Project Budget :';
        LblPeriod: Label 'PERIOD :';
        LblPONumber: Label 'PURCHASE ORDER NO.';
        LblPreEngage: Label 'Precommited';
        LblPurpose: Label 'PURPOSE OF EXPENDITURE';
        LblRealise: Label 'Realized';
        LblSubHead: Label 'Sub-Head No :';
        LblSupplier: Label 'SUPPLIER';
        LblTitle: Label 'BUDGET CONTROL AND FOLLOW-UP SHEET';
        DocStatus: Text;
        NatureName: Text;
        OrderPurpose: Text;
        TaskName: Text;
        TxtPeriod: Text;
        Supplier: Text[100];
        FooterLabel02Text: Text[250];



    local procedure PrepareLists()
    var
        GLEntry: Record "G/L Entry";
        PurchCreditMemo: Record "Purch. Cr. Memo Hdr.";
        PurchInvoice: Record "Purch. Inv. Header";
        PurchOrder: Record "Purchase Header";
        PurchOrderArchive: Record "Purchase Header Archive";
        i: Integer;
    //PurchaseInvoice: Record "Purchase Header Archive";
    begin
        OrderDatesListLength := 0;
        i := 1;

        //Engage
        PurchOrder.Reset();
        PurchOrder.SetRange(PurchOrder."Document Type", PurchOrder."Document Type"::Order);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 1 Code", TaskCode);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 2 Code", NatureCode);
        PurchOrder.SETFILTER(PurchOrder."Order Date", '%1..%2', DateDeb, DateFin);
        if PurchOrder.FindSet() then
            repeat
                OrderDatesList[i] := PurchOrder."Order Date";
                OrderNosList[i] := PurchOrder."No.";
                OrderTypeList[i] := 0;
                OrderDatesListLength := OrderDatesListLength + 1;
                i := i + 1;
            until PurchOrder.Next() = 0;

        /*
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
                        OrderTypeList[i] := 1;
                        OrderDatesListLength := OrderDatesListLength + 1;
                        i := i + 1;
                    end;
                until PurchOrderArchive.Next() = 0;
        */

        //engage facture directe
        PurchOrder.Reset();
        PurchOrder.SetRange(PurchOrder."Document Type", PurchOrder."Document Type"::Invoice);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 1 Code", TaskCode);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 2 Code", NatureCode);
        PurchOrder.SETFILTER(PurchOrder."Order Date", '%1..%2', DateDeb, DateFin);
        if PurchOrder.FindSet() then
            repeat
                OrderDatesList[i] := PurchOrder."Posting Date";
                OrderNosList[i] := PurchOrder."No.";
                OrderTypeList[i] := 5;
                OrderDatesListLength := OrderDatesListLength + 1;
                i := i + 1;
            until PurchOrder.Next() = 0;



        //Pre-engage
        PurchOrder.Reset();
        PurchOrder.SetRange(PurchOrder."Document Type", PurchOrder."Document Type"::Quote);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 1 Code", TaskCode);
        PurchOrder.SetRange(PurchOrder."Shortcut Dimension 2 Code", NatureCode);
        PurchOrder.SETFILTER(PurchOrder."Order Date", '%1..%2', DateDeb, DateFin);
        if PurchOrder.FindSet() then
            repeat
                OrderDatesList[i] := PurchOrder."Order Date";
                OrderNosList[i] := PurchOrder."No.";
                OrderTypeList[i] := 2;
                OrderDatesListLength := OrderDatesListLength + 1;
                i := i + 1;
            until PurchOrder.Next() = 0;

        //Realise

        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetFilter("G/L Account No.", AddOnSetup."Budgeted G/L Account Filter");
        GLEntry.SETRANGE("Posting Date", DateDeb, DateFin);
        GLEntry.SetRange("Global Dimension 1 Code", TaskCode);
        GLEntry.SetRange("Global Dimension 2 Code", NatureCode);
        if GLEntry.FindSet() then
            repeat
                OrderDatesList[i] := GLEntry."Posting Date";
                OrderNosList[i] := Format(GLEntry."Entry No.");
                OrderTypeList[i] := 3;
                OrderDatesListLength := OrderDatesListLength + 1;
                i := i + 1;
            until GLEntry.Next() = 0;



        /*
            PurchInvoice.Reset();
            PurchInvoice.SetCurrentKey("Order No.");
            PurchInvoice.SetRange(PurchInvoice."Order No.", '');
            PurchInvoice.SetRange("Shortcut Dimension 1 Code", TaskCode);
            PurchInvoice.SetRange("Shortcut Dimension 2 Code", NatureCode);
            PurchInvoice.SETFILTER("Posting Date", '%1..%2', DateDeb, DateFin);
            if PurchInvoice.FindSet() then
                repeat
                    OrderDatesList[i] := PurchInvoice."Posting Date";
                    OrderNosList[i] := PurchInvoice."No.";
                    OrderTypeList[i] := 3;
                    OrderDatesListLength := OrderDatesListLength + 1;
                    i := i + 1;
                until PurchInvoice.Next() = 0;


            PurchCreditMemo.Reset();
            //PurchCreditMemo.SetCurrentKey("Order No.");
            //PurchCreditMemo.SetRange("Order No.", '');
            PurchCreditMemo.SetRange("Shortcut Dimension 1 Code", TaskCode);
            PurchCreditMemo.SetRange("Shortcut Dimension 2 Code", NatureCode);
            PurchCreditMemo.SETFILTER("Posting Date", '%1..%2', DateDeb, DateFin);
            if PurchCreditMemo.FindSet() then
                repeat
                    OrderDatesList[i] := PurchCreditMemo."Posting Date";
                    OrderNosList[i] := PurchCreditMemo."No.";
                    OrderTypeList[i] := 4;
                    OrderDatesListLength := OrderDatesListLength + 1;
                    i := i + 1;
                until PurchCreditMemo.Next() = 0;
        */
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
        idValue: Integer;
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

                    idValue := OrderTypeList[i + 1];
                    OrderTypeList[i + 1] := OrderTypeList[i];
                    OrderTypeList[i] := idValue;

                    itemMoved := true;
                end;
            end;
        until itemMoved = false;
    end;

    local procedure FillLineOrder(PurchOrder: Record "Purchase Header";
        var OrderDate1: Date; var OrderAmount1: decimal; var CumulativeAmount1: decimal;
        var AvailableAmount1: decimal; var Supplier1: Text; var OrderPurpose1: Text)
    var
        BudgetControl: Codeunit AfkBudgetControl;
    begin
        OrderDate1 := PurchOrder."Order Date";
        OrderAmount1 := BudgetControl.GetDocPurchaseNotInvAmount(PurchOrder);
        //PurchOrder.CalcFields(not);
        //OrderAmount1 := PurchOrder.Amount;
        CumulativeAmount1 := CumulativeAmount + OrderAmount;
        AvailableAmount1 := InitialBudget - CumulativeAmount;
        Supplier1 := PurchOrder."Buy-from Vendor Name";
        OrderPurpose1 := PurchOrder.Afk_Object;
    end;

    local procedure FillLineArchiveOrder(PurchOrderArchive: Record "Purchase Header Archive";
        var OrderDate1: Date; var OrderAmount1: decimal; var CumulativeAmount1: decimal;
        var AvailableAmount1: decimal; var Supplier1: Text; var OrderPurpose1: Text)
    begin
        OrderDate1 := PurchOrderArchive."Order Date";
        PurchOrderArchive.CalcFields(Amount);
        OrderAmount1 := PurchOrderArchive.Amount;
        CumulativeAmount1 := CumulativeAmount + OrderAmount;
        AvailableAmount1 := InitialBudget - CumulativeAmount;
        Supplier1 := PurchOrderArchive."Buy-from Vendor Name";
        OrderPurpose1 := PurchOrderArchive.Afk_Object;
    end;

    local procedure FillLineInvoice(PurchInvoice: Record "Purch. Inv. Header";
        var OrderDate1: Date; var OrderAmount1: decimal; var CumulativeAmount1: decimal;
        var AvailableAmount1: decimal; var Supplier1: Text; var OrderPurpose1: Text)
    begin
        OrderDate1 := PurchInvoice."Posting Date";
        PurchInvoice.CalcFields(Amount);
        OrderAmount1 := PurchInvoice.Amount;
        CumulativeAmount1 := CumulativeAmount1 + OrderAmount1;
        AvailableAmount1 := InitialBudget - CumulativeAmount1;
        Supplier1 := PurchInvoice."Buy-from Vendor Name";
        OrderPurpose1 := '';//PurchInvoice.Afk_Object;
    end;

    local procedure FillLineInvoice(GLEntry: Record "G/L Entry"; var docNo: Code[20];
        var OrderDate1: Date; var OrderAmount1: decimal; var CumulativeAmount1: decimal;
        var AvailableAmount1: decimal; var Supplier1: Text; var OrderPurpose1: Text)
    var
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        PurchInvoice: Record "Purch. Inv. Header";
    begin
        OrderDate1 := GLEntry."Posting Date";
        OrderAmount1 := GLEntry.Amount;
        docNo := GLEntry."Document No.";
        CumulativeAmount1 := CumulativeAmount1 + OrderAmount1;
        AvailableAmount1 := InitialBudget - CumulativeAmount1;

        if (PurchCrMemo.get(GLEntry."Document No.")) then
            Supplier1 := PurchCrMemo."Buy-from Vendor Name"
        else
            if (PurchInvoice.get(GLEntry."Document No.")) then begin
                Supplier1 := PurchInvoice."Buy-from Vendor Name";
                OrderPurpose1 := PurchInvoice.Afk_Object;
            end;

        //PurchInvoice.Afk_Object;
    end;

    local procedure FillLineCreditMemo(PurchCreMemo: Record "Purch. Cr. Memo Hdr.";
        var OrderDate1: Date; var OrderAmount1: decimal; var CumulativeAmount1: decimal;
        var AvailableAmount1: decimal; var Supplier1: Text; var OrderPurpose1: Text)
    begin
        OrderDate1 := PurchCreMemo."Posting Date";
        PurchCreMemo.CalcFields(Amount);
        OrderAmount1 := -PurchCreMemo.Amount;
        CumulativeAmount1 := CumulativeAmount1 + OrderAmount1;
        AvailableAmount1 := InitialBudget - CumulativeAmount1;
        Supplier1 := PurchCreMemo."Buy-from Vendor Name";
        OrderPurpose1 := '';//PurchInvoice.Afk_Object;
    end;
}
