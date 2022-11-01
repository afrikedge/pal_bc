codeunit 50009 AfkBudgetControl
{
    trigger OnRun()
    begin

    end;






    procedure CreatePurchaseBudgetLines(PurchaseH: Record "Purchase Header"; CheckOnly: boolean)
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
                IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

                CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.",
                    OldAcc, OldCodeBudget, OldAccAmt, false);



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

            IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;
            BudgetLine."Dimension Code 1" := OldCodeBudget;
            BudgetLine."Document Amount" := OldAccAmt;

            CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget, OldAccAmt, false);

            //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;
            if not CheckOnly then
                IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;
    end;

    procedure CreatePurchaseBudgetLines_ItemReq(RequisitionH: Record AfkDocRequisition; CheckOnly: boolean)
    var
        BudgetLine: Record AfkDocRequisitionBudget;
        ReqLine: Record AfkDocRequisitionLine;
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

        GetPeriod(RequisitionH."Document Date", DateDeb, DateFin);
        //PurchaseH.TestField("Vendor Order No.");
        //MESSAGE('%1 - %2',DateDeb,DateFin);

        if not CheckOnly then begin
            CLEAR(BudgetLine);
            BudgetLine.SETRANGE("Document Type", RequisitionH."Document Type");
            BudgetLine.SETRANGE("Document No.", RequisitionH."No.");
            BudgetLine.DELETEALL;
        end;

        ReqLine.RESET;
        ReqLine.SETCURRENTKEY("Purchase Account", "Shortcut Dimension 1 Code");
        ReqLine.SETRANGE("Document Type", RequisitionH."Document Type");
        ReqLine.SETRANGE("Document No.", RequisitionH."No.");
        IF ReqLine.FINDSET THEN
            OldAcc := ReqLine."Purchase Account";
        OldCodeBudget := ReqLine."Shortcut Dimension 1 Code";
        REPEAT

            NewAcc := ReqLine."Purchase Account";
            NewDimValue1 := ReqLine."Shortcut Dimension 1 Code";
            CheckData(NewAcc, NewDimValue1, ReqLine."Line No.");

            IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewDimValue1)) THEN BEGIN
                CLEAR(BudgetLine);
                BudgetLine."Document Type" := RequisitionH."Document Type";
                BudgetLine."Document No." := RequisitionH."No.";
                BudgetLine."G/L Account No" := OldAcc;
                BudgetLine."Dimension Code 1" := OldCodeBudget;
                BudgetLine."Document Amount" := OldAccAmt;
                BudgetLine.AfkUserID := UserId;
                IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

                CalcValuesBudget(BudgetLine, RequisitionH."Document Date", RequisitionH."No.",
                    OldAcc, OldCodeBudget, OldAccAmt, true);



                if not CheckOnly then
                    IF OldAcc <> '' then BudgetLine.INSERT;

                OldAcc := ReqLine."Purchase Account";
                OldCodeBudget := ReqLine."Shortcut Dimension 1 Code";
                OldAccAmt := ConvertAmtLCY(RequisitionH."Document Date", ReqLine."Amount", RequisitionH."Currency Code");
            END ELSE BEGIN
                OldAccAmt := OldAccAmt + ConvertAmtLCY(RequisitionH."Document Date", ReqLine."Amount", RequisitionH."Currency Code");
            END;
            HaveLines := TRUE;
        UNTIL ReqLine.NEXT = 0;

        //Derniere ligne
        IF HaveLines THEN BEGIN
            CLEAR(BudgetLine);
            BudgetLine."Document Type" := RequisitionH."Document Type";
            BudgetLine."Document No." := RequisitionH."No.";
            BudgetLine."G/L Account No" := OldAcc;

            IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;
            BudgetLine."Dimension Code 1" := OldCodeBudget;
            BudgetLine."Document Amount" := OldAccAmt;

            CalcValuesBudget(BudgetLine, RequisitionH."Document Date", RequisitionH."No.", OldAcc, OldCodeBudget, OldAccAmt, true);

            //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;
            if not CheckOnly then
                IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;
    end;

    procedure CreatePurchaseBudgetLinesfromTracking(BudgetCode: Code[20]; TaskFilter: text[250]; NatureFilter: Text[250])
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

        GetPeriod(Today, DateDeb, DateFin);

        CLEAR(BudgetLine);
        BudgetLine.SetCurrentKey("Document Type", "AfkUserID");
        BudgetLine.SETRANGE("Document Type", BudgetLine."Document Type"::BudgetTracking);
        BudgetLine.SETRANGE("AfkUserID", UserId);
        BudgetLine.DELETEALL;

        GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
        if (NatureFilter <> '') then
            GLAcc.SetFilter("No.", NatureFilter);
        if (GLAcc.FindSet()) then
            repeat
                DimValue.SetRange("Global Dimension No.", 1);
                DimValue.SetRange(DimValue."Dimension Value Type", DimValue."Dimension Value Type"::Standard);
                if (TaskFilter <> '') then
                    DimValue.SetFilter(Code, TaskFilter);
                if (DimValue.FindSet()) then
                    repeat

                        CLEAR(BudgetLine);
                        BudgetLine."Document Type" := BudgetLine."Document Type"::BudgetTracking;
                        BudgetLine."AfkUserID" := UserId;


                        BudgetLine."G/L Account No" := GLAcc."No.";
                        BudgetLine."Dimension Code 1" := DimValue.Code;

                        BudgetLine."G/L Account Name" := GLAcc.Name;

                        BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', DimValue.Code);
                        BudgetLine."Budget Filter" := BudgetCode;
                        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
                        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

                        BudgetLine."Yearly Budgeted Amt" := BudgetLine."Budgeted Amount";
                        BudgetLine."Yearly PreCommitment" := GetPrecommitmentAmt(GLAcc."No.", DimValue.Code, '', DateDeb, DateFin, false)
                            + GetPrecommitmentAmt(GLAcc."No.", DimValue.Code, '', DateDeb, DateFin, true);
                        BudgetLine."Yearly Commitment" := GetCommitmentAmt(GLAcc."No.", DimValue.Code, '', DateDeb, DateFin, true)
                            + GetCommitmentAmt(GLAcc."No.", DimValue.Code, '', DateDeb, DateFin, false);
                        BudgetLine."Yearly Realized Amt" := BudgetLine."Net Change";
                        BudgetLine."Yearly Available Amt" := (BudgetLine."Yearly Budgeted Amt") -
                              (BudgetLine."Yearly PreCommitment" + BudgetLine."Yearly Commitment" + BudgetLine."Yearly Realized Amt");

                        if ((BudgetLine."Yearly Budgeted Amt" <> 0) or
                        (BudgetLine."Yearly PreCommitment" <> 0) or
                        (BudgetLine."Yearly Commitment" <> 0) or
                        (BudgetLine."Yearly Realized Amt" <> 0)) then
                            BudgetLine.Insert();


                    until DimValue.Next() = 0;
            until GLAcc.Next() = 0;

    end;

    procedure GetBudgetAmount(BudgetCode: Code[20]; TaskCode: Code[20]; GLAccountCode: Code[20]): Decimal
    var
        GLAccount: Record "G/L Account";
    begin
        if (GLAccount.Get(GLAccountCode)) then begin
            GLAccount.SetFilter(GLAccount."Global Dimension 1 Code", TaskCode);
            GLAccount.SetFilter(GLAccount."Budget Filter", BudgetCode);
            GLAccount.SetFilter(GLAccount."Date Filter", '%1..%2', GetStartOfYear(Today), GetEndOfYear(Today));
            GLAccount.CalcFields("Budgeted Amount");
            exit(GLAccount."Budgeted Amount");
        end;
    end;

    // procedure CreatePurchaseBudgetLinesFromReq(PurchaseH: Record "AfkDocRequisition")
    // var
    //     BudgetLine: Record AfkDocRequisitionBudget;
    //     GLAcc: Record "G/L Account";
    //     PurchLine: Record "Purchase Line";
    //     HaveLines: Boolean;
    //     NewAcc: Code[20];
    //     NewCodeBudget: Code[20];
    //     OldAcc: Code[20];
    //     OldCodeBudget: Code[20];
    //     CreationDate: Date;
    //     DateDeb: Date;
    //     DateFin: Date;
    //     OldAccAmt: Decimal;
    // begin

    //     CreationDate := DT2Date(PurchaseH.SystemCreatedAt);

    //     GetPeriod(CreationDate, DateDeb, DateFin);
    //     //MESSAGE('%1 - %2',DateDeb,DateFin);

    //     AddOnSetup.GET;
    //     AddOnSetup.TESTFIELD(AddOnSetup."Default Budget Code");

    //     CLEAR(BudgetLine);
    //     BudgetLine.SETRANGE("Document Type", BudgetLine."Document Type"::Requisition);
    //     BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
    //     BudgetLine.DELETEALL;

    //     PurchLine.RESET;
    //     PurchLine.SETCURRENTKEY("Afk_PurchaseAccount", "Shortcut Dimension 1 Code");
    //     //PurchLine.SETRANGE("Document Type",BudgetLine."Document Type"::Requisition);
    //     PurchLine.SETRANGE("Document No.", PurchaseH."No.");
    //     IF PurchLine.FINDSET THEN
    //         OldAcc := PurchLine."Afk_PurchaseAccount";
    //     OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
    //     REPEAT
    //         NewAcc := PurchLine."Afk_PurchaseAccount";
    //         NewCodeBudget := PurchLine."Shortcut Dimension 1 Code";
    //         CheckData(NewAcc, NewCodeBudget, PurchLine."Line No.");

    //         IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewCodeBudget)) THEN BEGIN
    //             CLEAR(BudgetLine);
    //             BudgetLine."Document Type" := BudgetLine."Document Type"::Requisition;
    //             BudgetLine."Document No." := PurchaseH."No.";
    //             BudgetLine."G/L Account No" := OldAcc;
    //             BudgetLine."Dimension Code 1" := OldCodeBudget;
    //             BudgetLine."Document Amount" := OldAccAmt;
    //             IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

    //             BudgetLine."Document Amount" := OldAccAmt;

    //             CalcValuesBudget(BudgetLine, CreationDate, PurchaseH."No.", OldAcc, OldCodeBudget, OldAccAmt);

    //             IF OldAcc <> '' THEN BudgetLine.INSERT;
    //             OldAcc := PurchLine."Afk_PurchaseAccount";
    //             OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
    //             //OldAccAmt:=ConvertAmtLCY(PurchaseH."Creation Date",PurchLine."Line Amount",PurchaseH."Currency Code");
    //         END ELSE BEGIN
    //             //OldAccAmt := OldAccAmt + ConvertAmtLCY(PurchaseH."Document Date",PurchLine."Line Amount",PurchaseH."Currency Code");
    //         END;

    //         HaveLines := TRUE;
    //     UNTIL PurchLine.NEXT = 0;


    //     //Derniere ligne
    //     IF HaveLines THEN BEGIN
    //         CLEAR(BudgetLine);
    //         BudgetLine."Document Type" := BudgetLine."Document Type"::Requisition;
    //         BudgetLine."Document No." := PurchaseH."No.";
    //         BudgetLine."G/L Account No" := OldAcc;

    //         IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;
    //         BudgetLine."Dimension Code 1" := OldCodeBudget;
    //         BudgetLine."Commitment Amount" := GetPrecommitmentAmt(OldAcc, OldCodeBudget, PurchaseH."No.", DateDeb, DateFin);
    //         BudgetLine."Document Amount" := OldAccAmt;

    //         CalcValuesBudget(BudgetLine, CreationDate, PurchaseH."No.", OldAcc, OldCodeBudget, OldAccAmt);

    //         IF OldAcc <> '' THEN BudgetLine.INSERT;
    //     END;

    // end;



    procedure GetPrecommitmentAmt(GLAccNo: Code[20];
    CodeBudget: Code[20];
    CodeDocToExclude: Code[20];
    DateDeb: Date; DateFin: Date; IsItem: Boolean) ReturnAmt: Decimal
    var
        ItemReqHeader: Record AfkDocRequisition;
        PurchHeader: Record "Purchase Header";
    begin

        if (IsItem) then begin

            ItemReqHeader.RESET;
            ItemReqHeader.SetRange(ItemReqHeader."Document Type", ItemReqHeader."Document Type"::ItemReq);
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
            //PurchHeader.SETFILTER(PurchHeader.Status, '%1|%2', PurchHeader.Status::Released, PurchHeader.Status::"Pending Prepayment");
            IF DateDeb <> 0D then
                PurchHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PurchHeader.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF PurchHeader."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(GLAccNo, CodeBudget, PurchHeader);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(GLAccNo, CodeBudget, PurchHeader);
                    END;
                UNTIL PurchHeader.NEXT = 0;

        end;





    end;

    procedure GetCommitmentAmt(GLAccNo: Code[20]; CodeBudget: Code[20];
    CodeDocToExclude: Code[20]; DateDeb: Date; DateFin: Date; IsItem: Boolean) ReturnAmt: Decimal
    var
        AfkDocItem: Record AfkDocRequisition;
        PurchHeader: Record "Purchase Header";
    begin

        if (IsItem) then begin
            AfkDocItem.RESET;
            AfkDocItem.SetRange(AfkDocItem.Status, AfkDocItem.Status::Released);
            AfkDocItem.SetRange(AfkDocItem."Document Type", AfkDocItem."Document Type"::ItemReq);
            IF DateDeb <> 0D then
                AfkDocItem.SETRANGE("Document Date", DateDeb, DateFin);
            IF AfkDocItem.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF AfkDocItem."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocReleaseNotDeliveredAmount(GLAccNo, CodeBudget, AfkDocItem);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocReleaseNotDeliveredAmount(GLAccNo, CodeBudget, AfkDocItem);
                    END;
                UNTIL AfkDocItem.NEXT = 0;

        end else begin

            PurchHeader.RESET;
            PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Order);
            //PurchHeader.SETFILTER(PurchHeader.Status, '%1|%2', PurchHeader.Status::Released, PurchHeader.Status::"Pending Prepayment");
            IF DateDeb <> 0D then
                PurchHeader.SETRANGE("Document Date", DateDeb, DateFin);
            IF PurchHeader.FINDSET THEN
                REPEAT
                    IF CodeDocToExclude <> '' THEN BEGIN
                        IF PurchHeader."No." <> CodeDocToExclude THEN
                            ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(GLAccNo, CodeBudget, PurchHeader);
                    END ELSE BEGIN
                        ReturnAmt := ReturnAmt + GetDocPurchaseNotInvAmount(GLAccNo, CodeBudget, PurchHeader);
                    END;
                UNTIL PurchHeader.NEXT = 0;
        end;
    end;


    // procedure GetPrecommitmentAmt(PurchaseH: Record "Purchase Header")
    // var
    //     BudgetLine: Record AfkDocRequisitionBudget;
    //     GLAcc: Record "G/L Account";
    //     PurchLine: Record "Purchase Line";
    //     HaveLines: Boolean;
    //     NewAcc: Code[20];
    //     NewCodeAxe1: Code[20];
    //     OldAcc: Code[20];
    //     OldCodeBudget: Code[20];
    //     DateDeb: Date;
    //     DateFin: Date;
    //     OldAccAmt: Decimal;
    // begin

    //     GetPeriod(PurchaseH."Document Date", DateDeb, DateFin);

    //     CLEAR(BudgetLine);
    //     BudgetLine.SETRANGE("Document Type", PurchaseH."Document Type");
    //     BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
    //     BudgetLine.DELETEALL;

    //     PurchLine.RESET;
    //     // PurchLine.SETCURRENTKEY(Afk_PurchaseAccount, "Shortcut Dimension 1 Code");
    //     PurchLine.SETRANGE("Document Type", PurchaseH."Document Type");
    //     PurchLine.SETRANGE("Document No.", PurchaseH."No.");
    //     IF PurchLine.FINDSET THEN
    //         OldAcc := PurchLine.Afk_PurchaseAccount;
    //     OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
    //     REPEAT

    //         NewAcc := PurchLine.Afk_PurchaseAccount;
    //         NewCodeAxe1 := PurchLine."Shortcut Dimension 1 Code";
    //         CheckData(NewAcc, NewCodeAxe1, PurchLine."Line No.");

    //         IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewCodeAxe1)) THEN BEGIN
    //             CLEAR(BudgetLine);
    //             BudgetLine."Document Type" := PurchaseH."Document Type";
    //             BudgetLine."Document No." := PurchaseH."No.";
    //             BudgetLine."G/L Account No" := OldAcc;
    //             BudgetLine."Dimension Code 1" := OldCodeBudget;
    //             IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

    //             CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

    //             IF OldAcc <> '' THEN BudgetLine.INSERT;
    //             OldAcc := PurchLine.Afk_PurchaseAccount;
    //             OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
    //             OldAccAmt := ConvertAmtLCY(PurchaseH."Document Date", PurchLine."Line Amount", PurchaseH."Currency Code");
    //         END ELSE BEGIN
    //             OldAccAmt := OldAccAmt + ConvertAmtLCY(PurchaseH."Document Date", PurchLine."Line Amount", PurchaseH."Currency Code");
    //         END;
    //         HaveLines := TRUE;
    //     UNTIL PurchLine.NEXT = 0;

    //     //Derniere ligne
    //     IF HaveLines THEN BEGIN
    //         CLEAR(BudgetLine);
    //         BudgetLine."Document Type" := PurchaseH."Document Type";
    //         BudgetLine."Document No." := PurchaseH."No.";
    //         BudgetLine."G/L Account No" := OldAcc;

    //         IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;
    //         BudgetLine."Dimension Code 1" := OldCodeBudget;
    //         BudgetLine."Document Amount" := OldAccAmt;

    //         CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

    //         //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;

    //         IF OldAcc <> '' THEN BudgetLine.INSERT;
    //     END;

    // end;

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
            DateRef: Date; CurrOrderNo: Code[20]; GLAcc: Code[20]; CodeAxe1: Code[20];
            DocumentAmount: decimal; IsItem: Boolean)
    var
        DateDeb: Date;
        DateFin: Date;
    begin

        AddOnSetup.GET;
        AddOnSetup.TESTFIELD(AddOnSetup."Default Budget Code");

        //Month
        /*
        GetPeriodDates(DateRef, AfkBudgetPeriodType::Month, DateDeb, DateFin);
        IF CodeAxe1 <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeAxe1);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Monthly Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Monthly Commitment" := GetPrecommitmentAmt(GLAcc, CodeAxe1, CurrOrderNo, DateDeb, DateFin);
        BudgetLine."Monthly Realized Amt" := BudgetLine."Net Change";
        BudgetLine."Monthly Available Amt" := (BudgetLine."Monthly Budgeted Amt") -
              (BudgetLine."Monthly Commitment" + BudgetLine."Monthly Realized Amt");
        */





        //Acc
        /*
        GetPeriodDates(DateRef, AfkBudgetPeriodType::Cumulative, DateDeb, DateFin);
        IF CodeAxe1 <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeAxe1);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Cumul Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Cumul Commitment" := GetPrecommitmentAmt(GLAcc, CodeAxe1, CurrOrderNo, DateDeb, DateFin,IsItem);
        BudgetLine."Cumul Realized Amt" := BudgetLine."Net Change";
        BudgetLine."Cumul Available Amt" := (BudgetLine."Cumul Budgeted Amt") -
              (BudgetLine."Cumul Commitment" + BudgetLine."Cumul Realized Amt");
        */

        //Year
        GetPeriodDates(DateRef, AfkBudgetPeriodType::Yearly, DateDeb, DateFin);
        IF CodeAxe1 <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeAxe1);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Yearly Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Yearly PreCommitment" := GetPrecommitmentAmt(GLAcc, CodeAxe1, CurrOrderNo, DateDeb, DateFin, IsItem);
        BudgetLine."Yearly Commitment" := GetCommitmentAmt(GLAcc, CodeAxe1, CurrOrderNo, DateDeb, DateFin, IsItem);
        BudgetLine."Yearly Realized Amt" := BudgetLine."Net Change";
        BudgetLine."Yearly Available Amt" := (BudgetLine."Yearly Budgeted Amt") -
              (BudgetLine."Yearly PreCommitment" + BudgetLine."Yearly Commitment" + BudgetLine."Yearly Realized Amt");


        UserSetup.Get(UserId);
        //if (AddOnSetup."Budget Period" = AddOnSetup."Budget Period"::Year) then
        if (DocumentAmount > BudgetLine."Yearly Available Amt") then begin
            if (not UserSetup.Afk_CanSkipBudgetControl) then begin
                if (AddOnSetup.BudgetControlMode = AddOnSetup.BudgetControlMode::Warning) then
                    Message(BudgetNotAvailbleMsg,
                        BudgetLine."Dimension Code 1",
                        BudgetLine."G/L Account No",
                        BudgetLine."Budgeted Amount",
                        BudgetLine."Yearly PreCommitment",
                        BudgetLine."Yearly Commitment",
                        BudgetLine."Yearly Realized Amt",
                        BudgetLine."Yearly Available Amt",
                        DocumentAmount);
                if (AddOnSetup.BudgetControlMode = AddOnSetup.BudgetControlMode::Block) then
                    Error(BudgetNotAvailbleMsg,
                        BudgetLine."Dimension Code 1",
                        BudgetLine."G/L Account No",
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



    local procedure GetDocPurchaseNotInvAmount(GLAccNo: Code[20]; CodeAxe1: Code[20]; PurchHeader: Record "Purchase Header") ReturnAmt: Decimal
    var
        PurchLine: Record "Purchase Line";
        LineAmt: Decimal;
    begin
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                IF ((PurchLine.Afk_PurchaseAccount = GLAccNo) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                    LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity - PurchLine."Quantity Invoiced");
                    ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
                END;
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocReleaseNotDeliveredAmount(GLAccNo: Code[20]; CodeAxe1: Code[20];
    PurchHeader: Record AfkDocRequisition) ReturnAmt: Decimal
    var
        PurchLine: Record AfkDocRequisitionLine;
        LineAmt: Decimal;

    begin
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                IF ((PurchLine."Purchase Account" = GLAccNo)
                AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                    LineAmt := PurchLine."Unit Cost" * (PurchLine.Quantity - PurchLine."Whse Delivered Quantity");
                    ReturnAmt := ReturnAmt + LineAmt;
                END;
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetDocItemRequisition(GLAccNo: Code[20]; CodeAxe1: Code[20]; PurchHeader: Record AfkDocRequisition) ReturnAmt: Decimal
    var
        PurchLine: Record AfkDocRequisitionLine;
        LineAmt: Decimal;
    begin
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                IF ((PurchLine."Purchase Account" = GLAccNo) AND (PurchLine."Shortcut Dimension 1 Code" = CodeAxe1)) THEN BEGIN
                    LineAmt := PurchLine.Amount;
                    ReturnAmt := ReturnAmt + LineAmt;//ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
                END;
            UNTIL PurchLine.NEXT = 0;
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