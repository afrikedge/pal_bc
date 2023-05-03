codeunit 50009 AfkBudgetControl
{
    trigger OnRun()
    begin

    end;






    procedure CreatePurchaseBudgetLines(PurchaseH: Record "Purchase Header"; CheckOnly: boolean)
    var
        BudgetLine: Record AfkDocRequisitionBudget;
        DimValue: Record "Dimension Value";
        GLAcc: Record "G/L Account";
        PurchLine: Record "Purchase Line";
        HaveLines: Boolean;
        NewAcc: Code[20];
        NewDimValue1: Code[20];
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        DateDeb: Date;
        DateFin: Date;
        OldAccAmt: Decimal;
    begin

        GLSetup.GetRecordOnce();
        AddOnSetup.Get();
        GetPeriod(PurchaseH."Document Date", DateDeb, DateFin);


        if not CheckOnly then begin
            CLEAR(BudgetLine);
            BudgetLine.SETRANGE("Document Type", PurchaseH."Document Type");
            BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
            BudgetLine.DELETEALL;
        end;

        AddOnSetup.TestField(BudgetGLAccount);
        PurchaseH.TestField("Shortcut Dimension 1 Code");
        PurchaseH.TestField("Shortcut Dimension 2 Code");

        BudgetLine.Init();
        BudgetLine."Document Type" := PurchaseH."Document Type";
        BudgetLine."Document No." := PurchaseH."No.";
        BudgetLine."G/L Account No" := AddOnSetup.BudgetGLAccount;
        BudgetLine."Dimension Code 1" := PurchaseH."Shortcut Dimension 1 Code";
        BudgetLine."Dimension Code 2" := PurchaseH."Shortcut Dimension 2 Code";
        BudgetLine.AfkUserID := UserId;
        BudgetLine."Document Amount" := GetPurchaseDocAmount(PurchaseH);
        IF DimValue.GET(GLSetup."Global Dimension 2 Code", PurchaseH."Shortcut Dimension 2 Code") then
            BudgetLine."Description" := DimValue.Name;

        CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.",
            PurchaseH."Shortcut Dimension 2 Code", PurchaseH."Shortcut Dimension 1 Code",
            BudgetLine."Document Amount");


        if not CheckOnly then
            BudgetLine.INSERT;


    end;


    procedure CreatePurchaseBudgetLinesxxx(PurchaseH: Record "Purchase Header"; CheckOnly: boolean)
    var
        BudgetLine: Record AfkDocRequisitionBudget;
        GLAcc: Record "G/L Account";
        PurchLine: Record "Purchase Line";
        HaveLines: Boolean;
        NewAcc: Code[20];
        NewDimValue1: Code[20];
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        DateDeb: Date;
        DateFin: Date;
        OldAccAmt: Decimal;
    begin

        GetPeriod(PurchaseH."Document Date", DateDeb, DateFin);
        //PurchaseH.TestField("Vendor Order No.");
        //MESSAGE('%1 - %2',DateDeb,DateFin);

        if not CheckOnly then begin
            CLEAR(BudgetLine);
            BudgetLine.SETRANGE("Document Type", PurchaseH."Document Type");
            BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
            BudgetLine.DELETEALL;
        end;

        PurchLine.RESET;
        PurchLine.SETCURRENTKEY(Afk_PurchaseAccount, "Shortcut Dimension 1 Code");
        PurchLine.SETRANGE("Document Type", PurchaseH."Document Type");
        PurchLine.SETRANGE("Document No.", PurchaseH."No.");
        REPEAT

            NewAcc := PurchLine.Afk_PurchaseAccount;
            NewDimValue1 := PurchLine."Shortcut Dimension 1 Code";
            CheckData(NewAcc, NewDimValue1, PurchLine."Line No.");

            IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewDimValue1)) THEN BEGIN
                CLEAR(BudgetLine);
                BudgetLine."Document Type" := PurchaseH."Document Type";
                BudgetLine."Document No." := PurchaseH."No.";
                BudgetLine."G/L Account No" := OldAcc;
                BudgetLine."Dimension Code 1" := OldCodeBudget;
                BudgetLine.AfkUserID := UserId;
                BudgetLine."Document Amount" := OldAccAmt;
                IF GLAcc.GET(OldAcc) THEN BudgetLine."Description" := GLAcc.Name;

                CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.",
                    OldAcc, OldCodeBudget, OldAccAmt);



                if not CheckOnly then
                    IF OldAcc <> '' then BudgetLine.INSERT;

                OldAcc := PurchLine.Afk_PurchaseAccount;
                OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
                OldAccAmt := ConvertAmtLCY(PurchaseH."Document Date", PurchLine."Line Amount", PurchaseH."Currency Code");
            END ELSE BEGIN
                OldAccAmt := OldAccAmt + ConvertAmtLCY(PurchaseH."Document Date", PurchLine."Line Amount", PurchaseH."Currency Code");
            END;
            HaveLines := TRUE;
        UNTIL PurchLine.NEXT = 0;

        //Derniere ligne
        IF HaveLines THEN BEGIN
            CLEAR(BudgetLine);
            BudgetLine."Document Type" := PurchaseH."Document Type";
            BudgetLine."Document No." := PurchaseH."No.";
            BudgetLine."G/L Account No" := OldAcc;

            IF GLAcc.GET(OldAcc) THEN BudgetLine."Description" := GLAcc.Name;
            BudgetLine."Dimension Code 1" := OldCodeBudget;
            BudgetLine."Document Amount" := OldAccAmt;

            CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget, OldAccAmt);

            //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;
            if not CheckOnly then
                IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;
    end;

    procedure CreatePurchaseBudgetLines_ItemReq(RequisitionH: Record AfkDocRequisition; CheckOnly: boolean)
    var
        BudgetLine: Record AfkDocRequisitionBudget;
        ReqLine: Record AfkDocRequisitionLine;
        DimValue: Record "Dimension Value";
        GLAcc: Record "G/L Account";
        HaveLines: Boolean;
        NewAcc: Code[20];
        NewDimValue1: Code[20];
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        DateDeb: Date;
        DateFin: Date;
        OldAccAmt: Decimal;
    begin

        GLSetup.GetRecordOnce();
        AddOnSetup.Get();
        GetPeriod(RequisitionH."Document Date", DateDeb, DateFin);

        if not CheckOnly then begin
            CLEAR(BudgetLine);
            BudgetLine.SETRANGE("Document Type", RequisitionH."Document Type");
            BudgetLine.SETRANGE("Document No.", RequisitionH."No.");
            BudgetLine.DELETEALL;
        end;

        AddOnSetup.TestField(BudgetGLAccount);
        RequisitionH.TestField("Shortcut Dimension 1 Code");
        RequisitionH.TestField("Shortcut Dimension 2 Code");
        RequisitionH.TestField(Description);


        BudgetLine.Init();
        BudgetLine."Document Type" := RequisitionH."Document Type";
        BudgetLine."Document No." := RequisitionH."No.";
        BudgetLine."G/L Account No" := AddOnSetup.BudgetGLAccount;
        BudgetLine."Dimension Code 1" := RequisitionH."Shortcut Dimension 1 Code";
        BudgetLine."Dimension Code 2" := RequisitionH."Shortcut Dimension 2 Code";
        BudgetLine."Document Amount" := GetDocItemReqAmount(RequisitionH);
        BudgetLine.AfkUserID := UserId;
        IF DimValue.GET(GLSetup."Global Dimension 2 Code", RequisitionH."Shortcut Dimension 2 Code") then
            BudgetLine."Description" := DimValue.Name;


        CalcValuesBudget(BudgetLine, RequisitionH."Document Date", RequisitionH."No.",
            RequisitionH."Shortcut Dimension 2 Code", RequisitionH."Shortcut Dimension 1 Code",
            BudgetLine."Document Amount");


        if not CheckOnly then
            BudgetLine.INSERT;

    end;

    procedure CreatePurchaseBudgetLinesfromTracking(BudgetCode: Code[20]; TaskFilter: text[250]; NatureFilter: Text[250]
    ; StructureFilter: Text[250])
    var
        BudgetLine: Record AfkDocRequisitionBudget;
        DimValNature: Record "Dimension Value";
        DimValTask: Record "Dimension Value";
        PurchLine: Record "Purchase Line";
        HaveLines: Boolean;
        NewAcc: Code[20];
        NewDimValue1: Code[20];
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        DateDeb: Date;
        DateFin: Date;
        OldAccAmt: Decimal;
    begin

        AddOnSetup.Get();
        AddOnSetup.TestField(BudgetGLAccount);
        GetPeriod(Today, DateDeb, DateFin);

        CLEAR(BudgetLine);
        BudgetLine.SetCurrentKey("Document Type", "AfkUserID");
        BudgetLine.SETRANGE("Document Type", BudgetLine."Document Type"::BudgetTracking);
        BudgetLine.SETRANGE("AfkUserID", UserId);
        BudgetLine.DELETEALL;

        DimValNature.SetRange("Global Dimension No.", 2);
        DimValNature.SetRange("Dimension Value Type", DimValNature."Dimension Value Type"::Standard);
        if (NatureFilter <> '') then
            DimValNature.SetFilter(Code, NatureFilter);
        if (DimValNature.FindSet()) then
            repeat
                DimValTask.SetRange("Global Dimension No.", 1);
                DimValTask.SetRange(DimValTask."Dimension Value Type", DimValTask."Dimension Value Type"::Standard);
                if (TaskFilter <> '') then
                    DimValTask.SetFilter(Code, TaskFilter);
                if (StructureFilter <> '') then
                    DimValTask.SetFilter(DimValTask.AfkBudgetStructure, StructureFilter);
                if (DimValTask.FindSet()) then
                    repeat

                        CLEAR(BudgetLine);
                        BudgetLine."Document Type" := BudgetLine."Document Type"::BudgetTracking;
                        BudgetLine."AfkUserID" := UserId;


                        BudgetLine."G/L Account No" := AddOnSetup.BudgetGLAccount;
                        BudgetLine."Dimension Code 1" := DimValTask.Code;
                        BudgetLine."Dimension Code 2" := DimValNature.Code;

                        BudgetLine."Description" := DimValNature.Name;

                        BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', DimValTask.Code);
                        BudgetLine.SETFILTER("Global Dimension 2 Filter", '%1', DimValNature.Code);
                        BudgetLine."Budget Filter" := BudgetCode;
                        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
                        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

                        BudgetLine."Yearly Budgeted Amt" := BudgetLine."Budgeted Amount";
                        BudgetLine."Yearly PreCommitment" := GetPrecommitmentAmt(DimValNature.Code, DimValTask.Code, DateDeb, DateFin);
                        BudgetLine."Yearly Commitment" := GetCommitmentAmt(DimValNature.Code, DimValTask.Code, DateDeb, DateFin);
                        BudgetLine."Yearly Realized Amt" := GetRealizedAmt(DimValNature.Code, DimValTask.Code, DateDeb, DateFin);
                        BudgetLine."Yearly Available Amt" := (BudgetLine."Yearly Budgeted Amt") -
                              (BudgetLine."Yearly PreCommitment" + BudgetLine."Yearly Commitment" + BudgetLine."Yearly Realized Amt");
                        if (BudgetLine."Yearly Budgeted Amt" <> 0) then
                            BudgetLine."Budget Execution" := (BudgetLine."Yearly Budgeted Amt" - BudgetLine."Yearly Available Amt") / BudgetLine."Yearly Budgeted Amt";
                        BudgetLine."Budget Execution" := Round(BudgetLine."Budget Execution" * 100);

                        if ((BudgetLine."Yearly Budgeted Amt" <> 0) or
                        (BudgetLine."Yearly PreCommitment" <> 0) or
                        (BudgetLine."Yearly Commitment" <> 0) or
                        (BudgetLine."Yearly Realized Amt" <> 0)) then
                            BudgetLine.Insert();


                    until DimValTask.Next() = 0;
            until DimValNature.Next() = 0;

    end;

    procedure GetBudgetAmount(BudgetCode: Code[20]; TaskCode: Code[20]; NatureCode: Code[20]): Decimal
    var
        GLAccount: Record "G/L Account";
    begin
        AddOnSetup.Get();
        AddOnSetup.TestField(BudgetGLAccount);
        if (GLAccount.Get(AddOnSetup.BudgetGLAccount)) then begin
            GLAccount.SetFilter(GLAccount."Global Dimension 1 Filter", TaskCode);
            GLAccount.SetFilter(GLAccount."Global Dimension 2 Filter", NatureCode);
            GLAccount.SetFilter(GLAccount."Budget Filter", BudgetCode);
            GLAccount.SetFilter(GLAccount."Date Filter", '%1..%2', GetStartOfYear(Today), GetEndOfYear(Today));
            GLAccount.CalcFields("Budgeted Amount");
            exit(GLAccount."Budgeted Amount");
        end;
    end;


    local procedure GetPrecommitmentAmt(CodeNature: Code[20];
            CodeTache: Code[20]; DateDeb: Date; DateFin: Date) ReturnAmt: Decimal
    var
        amt1: Decimal;
        amt2: Decimal;
    begin
        amt1 := GetPrecommitmentAmt(CodeNature, CodeTache, '', DateDeb, DateFin, true);
        amt2 := GetPrecommitmentAmt(CodeNature, CodeTache, '', DateDeb, DateFin, false);
        exit(amt1 + amt2);
    end;

    local procedure GetCommitmentAmt(CodeNature: Code[20];
            CodeTache: Code[20]; DateDeb: Date; DateFin: Date) ReturnAmt: Decimal
    var
        amt1: Decimal;
        amt2: Decimal;
    begin
        amt1 := GetcommitmentAmt(CodeNature, CodeTache, '', DateDeb, DateFin, true);
        amt2 := GetcommitmentAmt(CodeNature, CodeTache, '', DateDeb, DateFin, false);
        exit(amt1 + amt2);
    end;

    /*
        local procedure GetRealizedAmt(CodeNature: Code[20];
            CodeTache: Code[20]; DateDeb: Date; DateFin: Date) ReturnAmt: Decimal
    var
        amt1: Decimal;
        amt2: Decimal;
    begin
        amt1 := GetRealizedAmt(CodeNature, CodeTache, DateDeb, DateFin, true);
        amt2 := GetRealizedAmt(CodeNature, CodeTache, DateDeb, DateFin, false);
        exit(amt1 + amt2);
    end;
    */

    local procedure GetPrecommitmentAmt(CodeNature: Code[20];
    CodeTache: Code[20];
    CodeDocToExclude: Code[20];
    DateDeb: Date; DateFin: Date; IsItem: Boolean) ReturnAmt: Decimal
    var
        ItemReqHeader: Record AfkDocRequisition;
        PurchHeader: Record "Purchase Header";
    begin

        if (IsItem) then begin

            ItemReqHeader.RESET;
            ItemReqHeader.SetRange(ItemReqHeader."Document Type", ItemReqHeader."Document Type"::ItemReq);
            ItemReqHeader.SetRange(ItemReqHeader."Shortcut Dimension 1 Code", CodeTache);
            ItemReqHeader.SetRange(ItemReqHeader."Shortcut Dimension 2 Code", CodeNature);
            ItemReqHeader.SETFILTER(ItemReqHeader.Status, '%1|%2', ItemReqHeader.Status::Open, ItemReqHeader.Status::"Pending Approval");
            IF DateDeb <> 0D then
                ItemReqHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF ItemReqHeader.FINDSET THEN
                REPEAT
                    ItemReqHeader.CalcFields("Amount (LCY)");
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF ItemReqHeader."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + ItemReqHeader."Amount (LCY)";
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + +ItemReqHeader."Amount (LCY)";
                    END;
                UNTIL ItemReqHeader.NEXT = 0;

        end else begin

            PurchHeader.RESET;
            PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
            PurchHeader.SetRange(PurchHeader."Shortcut Dimension 1 Code", CodeTache);
            PurchHeader.SetRange(PurchHeader."Shortcut Dimension 2 Code", CodeNature);
            //PurchHeader.SETFILTER(PurchHeader.Status, '%1|%2', PurchHeader.Status::Released, PurchHeader.Status::"Pending Prepayment");
            IF DateDeb <> 0D then
                PurchHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PurchHeader.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF PurchHeader."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(PurchHeader);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(PurchHeader);
                    END;
                UNTIL PurchHeader.NEXT = 0;

        end;





    end;

    procedure GetCommitmentAmt(CodeNature: Code[20]; CodeTache: Code[20];
    CodeDocToExclude: Code[20]; DateDeb: Date; DateFin: Date; IsItem: Boolean) ReturnAmt: Decimal
    var
        AfkDocItem: Record AfkDocRequisition;
        PurchHeader: Record "Purchase Header";
    begin

        if (IsItem) then begin
            AfkDocItem.RESET;
            AfkDocItem.SetRange(AfkDocItem.Status, AfkDocItem.Status::Released);
            AfkDocItem.SetRange("Shortcut Dimension 1 Code", CodeTache);
            AfkDocItem.SetRange("Shortcut Dimension 2 Code", CodeNature);
            AfkDocItem.SetRange(AfkDocItem."Document Type", AfkDocItem."Document Type"::ItemReq);
            IF DateDeb <> 0D then
                AfkDocItem.SETRANGE("Document Date", DateDeb, DateFin);
            IF AfkDocItem.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF AfkDocItem."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocReleaseNotDeliveredAmount(AfkDocItem);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocReleaseNotDeliveredAmount(AfkDocItem);
                    END;
                UNTIL AfkDocItem.NEXT = 0;

        end else begin

            PurchHeader.RESET;
            //PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Order);
            PurchHeader.SetFilter(PurchHeader."Document Type", '%1|%2',
                PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice);
            PurchHeader.SetRange(PurchHeader."Shortcut Dimension 1 Code", CodeTache);
            PurchHeader.SetRange(PurchHeader."Shortcut Dimension 2 Code", CodeNature);
            //PurchHeader.SETFILTER(PurchHeader.Status, '%1|%2', PurchHeader.Status::Released, PurchHeader.Status::"Pending Prepayment");
            IF DateDeb <> 0D then
                PurchHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PurchHeader.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF PurchHeader."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(PurchHeader);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(PurchHeader);
                    END;
                UNTIL PurchHeader.NEXT = 0;
        end;
    end;

    procedure GetRealizedAmt(CodeNature: Code[20]; CodeTache: Code[20];
             DateDeb: Date; DateFin: Date) ReturnAmt: Decimal
    var
        GLEntry: Record "G/L Entry";
    //PostedCreditMemoHeader: Record "Purch. Cr. Memo Hdr.";
    //PostedPurchHeader: Record "Purch. Inv. Header";
    begin

        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetFilter("G/L Account No.", AddOnSetup."Budgeted G/L Account Filter");
        GLEntry.SETRANGE("Posting Date", DateDeb, DateFin);
        GLEntry.SetRange("Global Dimension 1 Code", CodeTache);
        GLEntry.SetRange("Global Dimension 2 Code", CodeNature);
        GLEntry.CalcSums("Amount");
        exit(GLEntry.Amount);

    end;

    procedure GetRealizedAmtxxx(CodeNature: Code[20]; CodeTache: Code[20];
         DateDeb: Date; DateFin: Date; IsItem: Boolean) ReturnAmt: Decimal
    var
        AfkDocItem: Record AfkWhseDelivery;
        PostedCreditMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PostedPurchHeader: Record "Purch. Inv. Header";
    begin

        if (IsItem) then begin
            AfkDocItem.RESET;
            //AfkDocItem.SetRange(AfkDocItem.Status, AfkDocItem.Status::Released);
            AfkDocItem.SetRange("Shortcut Dimension 1 Code", CodeTache);
            AfkDocItem.SetRange("Shortcut Dimension 2 Code", CodeNature);
            //AfkDocItem.SetRange(AfkDocItem."Document Type", AfkDocItem."Document Type"::ItemReq);
            IF DateDeb <> 0D then
                AfkDocItem.SETRANGE("Document Date", DateDeb, DateFin);
            IF AfkDocItem.FINDSET THEN
                REPEAT

                    ReturnAmt := ReturnAmt + GetDocRealizedDeliveredAmount(AfkDocItem);

                UNTIL AfkDocItem.NEXT = 0;

        end else begin

            //Purchase Invoices
            PostedPurchHeader.RESET;
            PostedPurchHeader.SetRange(PostedPurchHeader."Shortcut Dimension 1 Code", CodeTache);
            PostedPurchHeader.SetRange(PostedPurchHeader."Shortcut Dimension 2 Code", CodeNature);
            IF DateDeb <> 0D then
                PostedPurchHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PostedPurchHeader.FINDSET THEN
                REPEAT
                    ReturnAmt := ReturnAmt + GetDocPurchaseInvoicedAmount(PostedPurchHeader);
                UNTIL PostedPurchHeader.NEXT = 0;


            //Credit Memos
            PostedCreditMemoHeader.RESET;
            PostedCreditMemoHeader.SetRange("Shortcut Dimension 1 Code", CodeTache);
            PostedCreditMemoHeader.SetRange("Shortcut Dimension 2 Code", CodeNature);
            IF DateDeb <> 0D then
                PostedCreditMemoHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PostedCreditMemoHeader.FINDSET THEN
                REPEAT
                    ReturnAmt := ReturnAmt - GetDocPurchaseInvoicedCreditMemoAmount(PostedCreditMemoHeader);
                UNTIL PostedCreditMemoHeader.NEXT = 0;
        end;
    end;


    procedure GetPurchAcc(PurchLine: Record "Purchase Line"): Code[20]
    var
        FADepreciationGroup: Record "FA Depreciation Book";
        FAPostingGroup: Record "FA Posting Group";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";

    begin
        IF PurchLine.Type = PurchLine.Type::"G/L Account" THEN
            EXIT(PurchLine."No.");

        IF PurchLine.Type = PurchLine.Type::"Fixed Asset" THEN BEGIN
            FADepreciationGroup.GET(PurchLine."No.", PurchLine."Depreciation Book Code");
            FADepreciationGroup.TESTFIELD("FA Posting Group");
            FAPostingGroup.GET(FADepreciationGroup."FA Posting Group");
            FAPostingGroup.TESTFIELD("Acquisition Cost Account");
            EXIT(FAPostingGroup."Acquisition Cost Account");
        END;

        IF NOT GenPostingSetup.GET(PurchLine."Gen. Bus. Posting Group", PurchLine."Gen. Prod. Posting Group") THEN
            ERROR(Text008, PurchLine."Document No.", PurchLine."Line No.", PurchLine."Gen. Bus. Posting Group", PurchLine."Gen. Prod. Posting Group");


        IF PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order", PurchLine."Document Type"::"Credit Memo"] THEN BEGIN
            GenPostingSetup.TESTFIELD("Purch. Credit Memo Account");
            EXIT(GenPostingSetup."Purch. Credit Memo Account");
        END ELSE BEGIN
            GenPostingSetup.TESTFIELD("Purch. Account");
            EXIT(GenPostingSetup."Purch. Account");
        END;
    end;


    procedure GetPurchAccFromReq(PurchLine: Record AfkDocRequisitionLine; PurchReqH: Record "AfkDocRequisition"): Code[20]
    var
        FADepreciationGroup: Record "FA Depreciation Book";
        FAPostingGroup: Record "FA Posting Group";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";
        LoiAmort: Code[20];
    begin

        if (PurchReqH."Document Type" = PurchReqH."Document Type"::ItemReq) then
            exit(GetItemAdjustmentAcc(PurchLine));


        IF PurchLine.Type = PurchLine.Type::"G/L Account" THEN
            EXIT(PurchLine."No.");

        IF PurchLine.Type = PurchLine.Type::"Fixed Asset" THEN BEGIN
            FASetup.GET;
            LoiAmort := FASetup."Default Depr. Book";
            FADepreciationGroup.GET(PurchLine."No.", LoiAmort);
            FADepreciationGroup.TESTFIELD("FA Posting Group");
            FAPostingGroup.GET(FADepreciationGroup."FA Posting Group");
            FAPostingGroup.TESTFIELD("Acquisition Cost Account");
            EXIT(FAPostingGroup."Acquisition Cost Account");
        END;

        PurchReqH.TESTFIELD("Gen. Bus. Posting Group");
        IF NOT GenPostingSetup.GET(PurchReqH."Gen. Bus. Posting Group", PurchLine."Gen. Prod. Posting Group") THEN
            ERROR(Text009, PurchLine."Document No.", PurchLine."Line No.");


        //IF PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order",PurchLine."Document Type"::"Credit Memo"] THEN BEGIN
        //  GenPostingSetup.TESTFIELD("Purch. Credit Memo Account");
        //  EXIT(GenPostingSetup."Purch. Credit Memo Account");
        //END ELSE BEGIN
        GenPostingSetup.TESTFIELD("Purch. Account");
        EXIT(GenPostingSetup."Purch. Account");
        //END;
    end;

    procedure GetItemAdjustmentAcc(PRLine: Record AfkDocRequisitionLine): Code[20]
    var

        GenPostingSetup: Record "General Posting Setup";

    begin


        IF NOT GenPostingSetup.GET('', PRLine."Gen. Prod. Posting Group")
          THEN
            ERROR(Text008, '', PRLine."Gen. Prod. Posting Group");
        EXIT(GenPostingSetup."Inventory Adjmt. Account");


    end;



    procedure GetSalesAcc(SalesLine: Record "Sales Line"): Code[20]
    var
        FADepreciationGroup: Record "FA Depreciation Book";
        FAPostingGroup: Record "FA Posting Group";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";
        LoiAmort: Code[20];
    begin

        IF SalesLine.Type = SalesLine.Type::" " THEN
            EXIT('');

        IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN
            EXIT(SalesLine."No.");

        IF SalesLine.Type = SalesLine.Type::"Fixed Asset" THEN BEGIN
            FADepreciationGroup.GET(SalesLine."No.", SalesLine."Depreciation Book Code");
            FADepreciationGroup.TESTFIELD("FA Posting Group");
            FAPostingGroup.GET(FADepreciationGroup."FA Posting Group");
            FAPostingGroup.TESTFIELD(FAPostingGroup."Book Val. Acc. on Disp. (Gain)");
            EXIT(FAPostingGroup."Acquisition Cost Account");
        END;



        IF NOT GenPostingSetup.GET(SalesLine."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group")
          THEN
            ERROR(Text008, SalesLine."Document No.", SalesLine."Line No.");

        IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN BEGIN
            GenPostingSetup.TESTFIELD(GenPostingSetup."Sales Credit Memo Account");
            EXIT(GenPostingSetup."Sales Credit Memo Account");
        END ELSE BEGIN
            GenPostingSetup.TESTFIELD(GenPostingSetup."Sales Account");
            EXIT(GenPostingSetup."Sales Account");
        END;
    end;


    local procedure CalcValuesBudget(VAR BudgetLine: Record AfkDocRequisitionBudget;
            DateRef: Date; CurrOrderNo: Code[20]; CodeAxe2: Code[20]; CodeAxe1: Code[20];
            DocumentAmount: decimal)
    var
        DateDeb: Date;
        DateFin: Date;
    begin

        AddOnSetup.GET;
        AddOnSetup.TESTFIELD(AddOnSetup."Default Budget Code");
        AddOnSetup.TESTFIELD(AddOnSetup."Budgeted G/L Account Filter");



        //Year
        GetPeriodDates(DateRef, AfkBudgetPeriodType::Yearly, DateDeb, DateFin);
        IF CodeAxe1 <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeAxe1);
        IF CodeAxe2 <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 2 Filter", '%1', CodeAxe2);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Yearly Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Yearly PreCommitment" := GetPrecommitmentAmt(CodeAxe2, CodeAxe1, DateDeb, DateFin);
        BudgetLine."Yearly Commitment" := GetCommitmentAmt(CodeAxe2, CodeAxe1, DateDeb, DateFin);
        BudgetLine."Yearly Realized Amt" := GetRealizedAmt(CodeAxe2, CodeAxe1, DateDeb, DateFin);
        BudgetLine."Yearly Available Amt" := (BudgetLine."Yearly Budgeted Amt") -
              (BudgetLine."Yearly PreCommitment" + BudgetLine."Yearly Commitment" + BudgetLine."Yearly Realized Amt");
        if (BudgetLine."Yearly Budgeted Amt" <> 0) then
            BudgetLine."Budget Execution" := (BudgetLine."Yearly Budgeted Amt" - BudgetLine."Yearly Available Amt") / BudgetLine."Yearly Budgeted Amt";
        BudgetLine."Budget Execution" := Round(BudgetLine."Budget Execution" * 100);


        UserSetup.Get(UserId);
        //if (AddOnSetup."Budget Period" = AddOnSetup."Budget Period"::Year) then
        if (BudgetLine."Yearly Available Amt" < 0) then begin
            if (not UserSetup.Afk_CanSkipBudgetControl) then begin
                if (AddOnSetup.BudgetControlMode = AddOnSetup.BudgetControlMode::Warning) then
                    Message(BudgetNotAvailbleMsg,
                        BudgetLine."Dimension Code 1",
                        BudgetLine."Dimension Code 2",
                        BudgetLine."Budgeted Amount",
                        BudgetLine."Yearly PreCommitment",
                        BudgetLine."Yearly Commitment",
                        BudgetLine."Yearly Realized Amt",
                        BudgetLine."Yearly Available Amt",
                        DocumentAmount);
                if (AddOnSetup.BudgetControlMode = AddOnSetup.BudgetControlMode::Block) then
                    Error(BudgetNotAvailbleMsg,
                        BudgetLine."Dimension Code 1",
                        BudgetLine."Dimension Code 2",
                        BudgetLine."Budgeted Amount",
                        BudgetLine."Yearly PreCommitment",
                        BudgetLine."Yearly Commitment",
                        BudgetLine."Yearly Realized Amt",
                        BudgetLine."Yearly Available Amt",
                        DocumentAmount);
            end;
        end;

    end;

    local procedure CheckData(GLAcc: Code[20]; CodeBudget: Code[20]; LineNo: Integer)
    var
    begin
        IF GLAcc = '' THEN ERROR(Text011, LineNo);
        IF CodeBudget = '' THEN ERROR(Text012, LineNo);
    end;

    local procedure ConvertAmtLCY(PostingDate: Date; ForeignAmt: Decimal; CurrencyCode: Code[10]): Decimal
    var
        Currency: Record "Currency";
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyFactor: Decimal;
    begin
        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            CurrencyFactor := CurrExchRate.ExchangeRate(PostingDate, CurrencyCode);
        END;

        IF CurrencyCode <> '' THEN BEGIN
            EXIT(
              ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PostingDate, CurrencyCode, ForeignAmt, CurrencyFactor)
              , Currency."Amount Rounding Precision"));
        END ELSE BEGIN
            EXIT(ForeignAmt);
        END;
    end;


    local procedure GetPurchaseDocAmount(PurchHeader: Record "Purchase Header") ReturnAmt: Decimal
    var
        PurchLine: Record "Purchase Line";
        LineAmt: Decimal;
    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                //IF ((PurchLine."Shortcut Dimension 2 Code" = CodeAxe2) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity);
                ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
            //END;
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocItemReqAmount(PurchHeader: Record AfkDocRequisition) ReturnAmt: Decimal
    var
        PurchLine: Record AfkDocRequisitionLine;
        LineAmt: Decimal;
    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                //IF ((PurchLine."Shortcut Dimension 2 Code" = CodeAxe2) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                LineAmt := PurchLine."Amount (LCY)";
                ReturnAmt := ReturnAmt + LineAmt;
            //END;
            UNTIL PurchLine.NEXT = 0;
    end;

    procedure GetDocPurchaseNotInvAmount(PurchHeader: Record "Purchase Header") ReturnAmt: Decimal
    var
        PurchLine: Record "Purchase Line";
        LineAmt: Decimal;
    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                //IF ((PurchLine."Shortcut Dimension 2 Code" = CodeAxe2) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity - PurchLine."Quantity Invoiced");
                ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
            //END;
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocPurchaseInvoicedAmount(PurchHeader: Record "Purch. Inv. Header") ReturnAmt: Decimal
    var
        PurchLine: Record "Purch. Inv. Line";
        LineAmt: Decimal;
    begin

        PurchLine.RESET;
        //PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                //IF ((PurchLine."Shortcut Dimension 2 Code" = CodeAxe2) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity);
                ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
            //END;
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocPurchaseInvoicedCreditMemoAmount(PurchHeader: Record "Purch. Cr. Memo Hdr.") ReturnAmt: Decimal
    var
        PurchLine: Record "Purch. Cr. Memo Line";
        LineAmt: Decimal;
    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity);
                ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocReleaseNotDeliveredAmount(ReqHeader: Record AfkDocRequisition) ReturnAmt: Decimal
    var
        ReqLine: Record AfkDocRequisitionLine;
        LineAmt: Decimal;

    begin

        ReqLine.RESET;
        ReqLine.SETRANGE("Document Type", ReqHeader."Document Type");
        ReqLine.SETRANGE("Document No.", ReqHeader."No.");
        IF ReqLine.FINDSET THEN
            REPEAT
                //IF ((ReqLine."Shortcut Dimension 2 Code" = CodeAxe2)
                //AND (ReqLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                LineAmt := ReqLine."Unit Cost" * (ReqLine.Quantity - ReqLine."Whse Delivered Quantity");
                ReturnAmt := ReturnAmt + LineAmt;
            //END;
            UNTIL ReqLine.NEXT = 0;
    end;

    local procedure GetDocRealizedDeliveredAmount(ReqHeader: Record AfkWhseDelivery) ReturnAmt: Decimal
    var
        ReqLine: Record AfkWhseDeliveryLine;
        LineAmt: Decimal;

    begin

        ReqLine.RESET;
        //ReqLine.SETRANGE("Document Type", ReqHeader."Document Type");
        ReqLine.SETRANGE("Document No.", ReqHeader."No.");
        IF ReqLine.FINDSET THEN
            REPEAT

                LineAmt := ReqLine."Unit Cost" * (ReqLine.Quantity);
                ReturnAmt := ReturnAmt + LineAmt;

            UNTIL ReqLine.NEXT = 0;
    end;



    procedure GetStartOfYear(DateRef: Date): Date
    begin
        IF DateRef <> 0D THEN
            exit(DMY2Date(1, 1, DATE2DMY(DateRef, 3)));   //Debut de l'année de DateRef - AnneeRef
    end;

    procedure GetEndOfYear(DateRef: Date): Date
    begin
        IF DateRef <> 0D THEN
            exit(DMY2Date(31, 12, DATE2DMY(DateRef, 3)));   //Debut de l'année de DateRef - AnneeRef
    end;



    local procedure GetPeriod(DateRef: Date; VAR DateDeb: Date; VAR DateFin: Date)
    var
    begin
        AddOnSetup.GET;

        IF AddOnSetup."Budget Period" = AddOnSetup."Budget Period"::None THEN BEGIN
            DateDeb := 0D;
            DateFin := 0D;
        END;

        IF AddOnSetup."Budget Period" = AddOnSetup."Budget Period"::Year THEN BEGIN
            DateDeb := DMY2DATE(1, 1, DATE2DMY(DateRef, 3));
            DateFin := DMY2DATE(31, 12, DATE2DMY(DateRef, 3));
        END;

        IF AddOnSetup."Budget Period" = AddOnSetup."Budget Period"::Month THEN BEGIN
            DateDeb := DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3));
            DateFin := CALCDATE('<1M>', DateRef);
        END;
    end;

    local procedure GetPeriodDates(DateRef: Date; Type: Enum AfkBudgetPeriodType; VAR DateDeb: Date; VAR DateFin: Date)
    var
        DebutMois: Date;
    begin
        //Month
        IF Type = AfkBudgetPeriodType::Month THEN BEGIN
            DateDeb := DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3));
            DateFin := CALCDATE('<1M-1D>', DateDeb);
        END;

        //Acc
        IF Type = AfkBudgetPeriodType::Cumulative THEN BEGIN
            DateDeb := DMY2DATE(1, 1, DATE2DMY(DateRef, 3));
            DebutMois := DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3));
            DateFin := CALCDATE('<1M-1D>', DebutMois);
        END;

        //Year
        IF Type = AfkBudgetPeriodType::Yearly THEN BEGIN
            DateDeb := DMY2DATE(1, 1, DATE2DMY(DateRef, 3));
            DateFin := DMY2DATE(31, 12, DATE2DMY(DateRef, 3));
        END;
    end;






    var
        SRDoc: Record "AfkDocRequisition";
        AddOnSetup: Record AfkSetup;
        FASetup: Record "FA Setup";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        DimMgt: Codeunit DimensionManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        BudgetNotAvailbleMsg: Label 'The budget is insufficient for task %1, Nature %2. \Budgeted amount is %3, \pre-committed amount is %4, committed amount is %5, realized amount is %6, available amount is %7, document amount is %8';
        Text008: Label 'Posting groups not defined on command line %1 - %2 - (%3 - %4)';
        Text009: Label 'Posting groups not defined on purchase requisition line %1 - %2';
        Text011: Label 'Purchase account is invalid on line %1';
        Text012: Label 'Task code not filled in on line %1';
}