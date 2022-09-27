codeunit 50004 AfkPurchaseReqMgt
{
    trigger OnRun()
    begin
    end;

    procedure CreateOpenNewOffer()
    var
        SRLine: Record AfkPurchaseRequisitionLine;
        PurchQuoteH: Record "Purchase Header";
        QuoteCard: Page "Purchase Quote";

    begin
        SRDoc.TESTFIELD(SRDoc.Status, SRDoc.Status::Released);

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document No.", SRDoc."No.");
        IF SRLine.ISEMPTY THEN ERROR(Text002);

        IF DDATotalementFacturee(SRDoc) THEN
            ERROR(Text032);


        CLEAR(PurchQuoteH);
        PurchQuoteH."Document Type" := PurchQuoteH."Document Type"::Quote;
        PurchQuoteH.Afk_RequisitionCode := SRDoc."No.";
        PurchQuoteH."Requested Receipt Date" := SRDoc."Requested Receipt Date";
        PurchQuoteH."PR Type" := SRDoc."PR Type";
        PurchQuoteH."PO Type" := SRDoc."PO Type";
        PurchQuoteH."PR Description" := SRDoc.Description;
        PurchQuoteH."No." := '';
        PurchQuoteH.INSERT(TRUE);


        QuoteCard.SETTABLEVIEW(PurchQuoteH);
        QuoteCard.SETRECORD(PurchQuoteH);
        QuoteCard.RUN;
    end;

    procedure CreateLinesOffer(Devis: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        SRLine: Record AfkPurchaseRequisitionLine;
        LineNo: Integer;
        SRDoc: Record AfkPurchaseRequisition;
        QteRestante: Decimal;

    begin
        IF Devis."Document Type" <> Devis."Document Type"::Quote THEN EXIT;
        IF Devis.Afk_RequisitionCode = '' THEN EXIT;

        SRDoc.GET(Devis.Afk_RequisitionCode);
        Devis."Budget Code" := SRDoc."Budget Code";
        Devis."Purchase Type" := SRDoc."Purchase Type";
        //Devis."Purchaser Code" := SRDoc."Purchaser Code";

        //IF Devis."Purchaser Code" = '' THEN
        //    Devis."Purchaser Code" := GetUserPurchaseCode(USERID);

        //Devis.Description := SRDoc.Description;
        Devis.VALIDATE("Shortcut Dimension 1 Code", SRDoc."Shortcut Dimension 1 Code");
        Devis.VALIDATE("Shortcut Dimension 2 Code", SRDoc."Shortcut Dimension 2 Code");
        Devis."Dimension Set ID" := SRDoc."Dimension Set ID";
        Devis.VALIDATE("Expected Receipt Date", SRDoc."Requested Receipt Date");

        Devis.MODIFY(TRUE);
        Devis.TESTFIELD(Devis."Buy-from Vendor No.");

        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Quote);
        PurchLine.SETRANGE(PurchLine."Document No.", Devis."No.");
        IF NOT PurchLine.ISEMPTY THEN EXIT;

        LineNo := 10000;
        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document No.", Devis.Afk_RequisitionCode);
        IF SRLine.FINDSET THEN
            REPEAT
                PurchLine.INIT;
                PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                PurchLine."Document No." := Devis."No.";
                PurchLine."Line No." := LineNo;
                LineNo := LineNo + 10000;

                //PurchLine.Type:=SRLine.Type;
                IF SRLine.Type = SRLine.Type::" " THEN PurchLine.Type := PurchLine.Type::" ";
                IF SRLine.Type = SRLine.Type::Item THEN PurchLine.Type := PurchLine.Type::Item;
                IF SRLine.Type = SRLine.Type::"Fixed Asset" THEN PurchLine.Type := PurchLine.Type::"Fixed Asset";
                IF SRLine.Type = SRLine.Type::"G/L Account" THEN PurchLine.Type := PurchLine.Type::"G/L Account";
                IF SRLine.Type = SRLine.Type::"Charge (Item)" THEN PurchLine.Type := PurchLine.Type::"Charge (Item)";

                IF SRLine.Type <> SRLine.Type::" " THEN
                    PurchLine.VALIDATE("No.", SRLine."No.");
                PurchLine.Description := SRLine.Description;
                PurchLine."Dimension Set ID" := SRLine."Dimension Set ID";

                PurchLine.Afk_PurchReqNo := SRLine."Document No.";
                PurchLine.Afk_PurchReqLineNo := SRLine."Line No.";

                IF SRLine.Type <> SRLine.Type::" " THEN BEGIN
                    QteRestante := UOMMgt.CalcQtyFromBase(SRLine."Quantity (Base)" - SRLine."Ordered Quantity (Base)", SRLine."Qty. per Unit of Measure");
                    PurchLine.VALIDATE(Quantity, QteRestante);
                    PurchLine.VALIDATE("Unit of Measure Code", SRLine."Unit of Measure Code");
                    PurchLine.VALIDATE("Direct Unit Cost", 0);
                END;
                //PurchLine.VALIDATE("Direct Unit Cost",SRLine."Prix Unitaire");
                //PurchLine."Code Nature":=SRLine."Nature code";
                //PurchLine."Code projet":=SRLine."Project Code";
                //PurchLine."Serial No." := SRLine."Serial No.";
                //PurchLine."Item Ref" := SRLine."Item Ref";
                IF (SRLine.Type = SRLine.Type::" ") THEN
                    PurchLine.INSERT(TRUE)
                ELSE
                    IF QteRestante > 0 THEN
                        PurchLine.INSERT(TRUE);

            UNTIL SRLine.NEXT = 0;

    end;

    procedure CloturerDemande(var SRequisition: Record AfkPurchaseRequisition;
            CodeDocCree: Code[20]; TypeDocCree: Option Commande,Contrat;
            CodeOffreRetenue: Code[20])
    var
        EnteteOffre: Record "Purchase Header";
        SRLine: Record AfkPurchaseRequisitionLine;
        PostedServiceRequisition: Record AfkPostedPurchaseRequisition;
        PurchQuoteLine: Record "Purchase Line";
        PostedLineServR: Record AfkPostPurchaseRequisitionLine;
    begin

        SRequisition.TESTFIELD(Status, SRequisition.Status::Released);

        IF NOT CONFIRM(Text010) THEN EXIT;

        //Archiver toutes les offres fournisseur

        EnteteOffre.RESET;
        EnteteOffre.SETRANGE(EnteteOffre."Document Type", EnteteOffre."Document Type"::Quote);
        EnteteOffre.SETRANGE(EnteteOffre.Afk_RequisitionCode, SRequisition."No.");
        IF EnteteOffre.FINDSET THEN
            REPEAT
                //IF (EnteteOffre."No."<>CodeOffreRetenue) THEN
                //  ArchiveMgt.StorePurchDocument(EnteteOffre,FALSE);
                ArchiveManagement.ArchPurchDocumentNoConfirm(EnteteOffre);

                //Supprimer les autres offres de service
                IF (EnteteOffre."No." <> CodeOffreRetenue) THEN BEGIN

                    PurchQuoteLine.RESET;
                    PurchQuoteLine.SETRANGE("Document Type", PurchQuoteLine."Document Type"::Quote);
                    PurchQuoteLine.SETRANGE("Document No.", EnteteOffre."No.");
                    PurchQuoteLine.DELETEALL;

                    EnteteOffre.DELETELINKS;
                    EnteteOffre.DELETE(TRUE);
                END;

            UNTIL EnteteOffre.NEXT = 0;



        //Archiver la demande de service
        PostedServiceRequisition.INIT;
        PostedServiceRequisition.TRANSFERFIELDS(SRequisition);

        PostedServiceRequisition."Created Doc Type" := PostedServiceRequisition."Created Doc Type"::Commande;
        PostedServiceRequisition."Created Doc Code" := CodeDocCree;
        PostedServiceRequisition.Status := PostedServiceRequisition.Status::Released;
        PostedServiceRequisition."Closed Date" := TODAY;
        PostedServiceRequisition."Closed By" := USERID;

        PostedServiceRequisition.COPYLINKS(SRequisition);
        PostedServiceRequisition.INSERT;


        SRLine.RESET;
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                //IF SRLine."No."<>'' THEN
                //  SRLine.TESTFIELD(SRLine."Code Nature");
                PostedLineServR.TRANSFERFIELDS(SRLine);
                PostedLineServR.INSERT;
            UNTIL SRLine.NEXT = 0;



        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        SRLine.DELETEALL;

        SRequisition.DELETELINKS;
        SRequisition.DELETE(TRUE);
    end;

    procedure GetPurchAcc(PurchLine: Record "Purchase Line"): Code[20]
    var
        FADepreciationGroup: Record "FA Depreciation Book";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";
        FAPostingGroup: Record "FA Posting Group";

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


    procedure GetPurchAccFromReq(PurchLine: Record AfkPurchaseRequisitionLine; PurchReqH: Record AfkPurchaseRequisition): Code[20]
    var
        LoiAmort: Code[20];
        FADepreciationGroup: Record "FA Depreciation Book";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";
        FAPostingGroup: Record "FA Posting Group";
    begin

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


    procedure GetSalesAcc(SalesLine: Record "Sales Line"): Code[20]
    var
        LoiAmort: Code[20];
        FADepreciationGroup: Record "FA Depreciation Book";
        Immo: Record "Fixed Asset";
        GenPostingSetup: Record "General Posting Setup";
        FAPostingGroup: Record "FA Posting Group";
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


    procedure GetPrecommitmentAmt(GLAccNo: Code[20]; CodeBudget: Code[20]; CodeDocToExclude: Code[20]; DateDeb: Date; DateFin: Date) ReturnAmt: Decimal
    var
        PurchHeader: Record "Purchase Header";
    begin

        PurchHeader.RESET;
        PurchHeader.SETFILTER(PurchHeader.Status, '%1|%2', PurchHeader.Status::Released, PurchHeader.Status::"Pending Prepayment");
        IF DateDeb <> 0D THEN PurchHeader.SETRANGE("Posting Date", DateDeb, DateFin);
        IF PurchHeader.FINDSET THEN
            REPEAT
                IF CodeDocToExclude <> '' THEN BEGIN
                    IF PurchHeader."No." <> CodeDocToExclude THEN
                        ReturnAmt := ReturnAmt + GetDocAmount(GLAccNo, CodeBudget, PurchHeader);
                END ELSE BEGIN
                    ReturnAmt := ReturnAmt + GetDocAmount(GLAccNo, CodeBudget, PurchHeader);
                END;
            UNTIL PurchHeader.NEXT = 0;
    end;


    procedure GetPrecommitmentAmt(PurchaseH: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        BudgetLine: Record AfkPurchaseRequisitionBudget;
        OldAcc: Code[20];
        OldAccAmt: Decimal;
        HaveLines: Boolean;
        NewAcc: Code[20];
        GLAcc: Record "G/L Account";
        DateDeb: Date;
        DateFin: Date;
        OldCodeBudget: Code[20];
        NewCodeBudget: Code[20];
    begin

        GetPeriod(PurchaseH."Document Date", DateDeb, DateFin);

        CLEAR(BudgetLine);
        BudgetLine.SETRANGE("Document Type", PurchaseH."Document Type");
        BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
        BudgetLine.DELETEALL;

        PurchLine.RESET;
        PurchLine.SETCURRENTKEY(Afk_PurchaseAccount, "Shortcut Dimension 1 Code");
        PurchLine.SETRANGE("Document Type", PurchaseH."Document Type");
        PurchLine.SETRANGE("Document No.", PurchaseH."No.");
        IF PurchLine.FINDSET THEN
            OldAcc := PurchLine.Afk_PurchaseAccount;
        OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
        REPEAT

            NewAcc := PurchLine.Afk_PurchaseAccount;
            NewCodeBudget := PurchLine."Shortcut Dimension 1 Code";
            CheckData(NewAcc, NewCodeBudget, PurchLine."Line No.");

            IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewCodeBudget)) THEN BEGIN
                CLEAR(BudgetLine);
                BudgetLine."Document Type" := PurchaseH."Document Type";
                BudgetLine."Document No." := PurchaseH."No.";
                BudgetLine."G/L Account No" := OldAcc;
                BudgetLine."Dimension Code 1" := OldCodeBudget;
                IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

                CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

                IF OldAcc <> '' THEN BudgetLine.INSERT;
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

            CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

            //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;

            IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;

    end;


    local procedure CalcValuesBudget(VAR BudgetLine: Record AfkPurchaseRequisitionBudget; DateRef: Date; CurrOrderNo: Code[20]; GLAcc: Code[20]; CodeBudget: Code[20])
    var
        DateDeb: Date;
        DateFin: Date;
    begin

        AddOnSetup.GET;
        AddOnSetup.TESTFIELD(AddOnSetup."Default Budget Code");

        //Month
        GetPeriodDates(DateRef, 1, DateDeb, DateFin);
        IF CodeBudget <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeBudget);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Monthly Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Monthly Commitment" := GetPrecommitmentAmt(GLAcc, CodeBudget, CurrOrderNo, DateDeb, DateFin);
        BudgetLine."Monthly Realized Amt" := BudgetLine."Net Change";
        BudgetLine."Monthly Available Amt" := (BudgetLine."Monthly Budgeted Amt") -
              (BudgetLine."Monthly Commitment" + BudgetLine."Monthly Realized Amt");


        //Acc
        GetPeriodDates(DateRef, 2, DateDeb, DateFin);
        IF CodeBudget <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeBudget);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Acc Budgeted Amt" := BudgetLine."Budgeted Amount";
        BudgetLine."Acc Commitment" := GetPrecommitmentAmt(GLAcc, CodeBudget, CurrOrderNo, DateDeb, DateFin);
        BudgetLine."Acc Realized Amt" := BudgetLine."Net Change";
        BudgetLine."Acc Available Amt" := (BudgetLine."Acc Budgeted Amt") -
              (BudgetLine."Acc Commitment" + BudgetLine."Acc Realized Amt");


        //Year
        GetPeriodDates(DateRef, 3, DateDeb, DateFin);
        IF CodeBudget <> '' THEN
            BudgetLine.SETFILTER("Global Dimension 1 Filter", '%1', CodeBudget);
        BudgetLine."Budget Filter" := AddOnSetup."Default Budget Code";
        BudgetLine.SETFILTER("Date Filter", '%1..%2', DateDeb, DateFin);
        BudgetLine.CALCFIELDS("Net Change", "Budgeted Amount");

        BudgetLine."Yearly Budgeted Amt" := BudgetLine."Budgeted Amount";
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

    local procedure GetPeriodDates(DateRef: Date; Type: Integer; VAR DateDeb: Date; VAR DateFin: Date)
    var
        DebutMois: Date;
    begin
        //Month
        IF Type = 1 THEN BEGIN
            DateDeb := DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3));
            DateFin := CALCDATE('<1M-1D>', DateDeb);
        END;

        //Acc
        IF Type = 2 THEN BEGIN
            DateDeb := DMY2DATE(1, 1, DATE2DMY(DateRef, 3));
            DebutMois := DMY2DATE(1, DATE2DMY(DateRef, 2), DATE2DMY(DateRef, 3));
            DateFin := CALCDATE('<1M-1D>', DebutMois);
        END;

        //Year
        IF Type = 3 THEN BEGIN
            DateDeb := DMY2DATE(1, 1, DATE2DMY(DateRef, 3));
            DateFin := DMY2DATE(31, 12, DATE2DMY(DateRef, 3));
        END;
    end;

    local procedure CheckData(GLAcc: Code[20]; CodeBudget: Code[20]; LineNo: Integer)
    var
    begin
        IF GLAcc = '' THEN ERROR(Text011, LineNo);
        IF CodeBudget = '' THEN ERROR(Text012, LineNo);
    end;


    local procedure GetDocAmount(GLAccNo: Code[20]; CodeBudget: Code[20]; PurchHeader: Record "Purchase Header") ReturnAmt: Decimal
    var
        PurchLine: Record "Purchase Line";
        LineAmt: Decimal;
        QtyInvoiced: Decimal;
        PartiallyProcess: Boolean;
        TotallyProcess: Boolean;
    begin
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDSET THEN
            REPEAT
                IF ((PurchLine.Afk_PurchaseAccount = GLAccNo) AND (PurchLine."Shortcut Dimension 1 Code" = CodeBudget)) THEN BEGIN
                    LineAmt := PurchLine."Direct Unit Cost" * (PurchLine.Quantity - PurchLine."Quantity Invoiced");
                    ReturnAmt := ReturnAmt + ConvertAmtLCY(PurchHeader."Document Date", LineAmt, PurchHeader."Currency Code");
                END;
            UNTIL PurchLine.NEXT = 0;
    end;

    procedure CreatePurchaseBudgetLines(PurchaseH: Record "Purchase Header")
    var
        BudgetLine: Record AfkPurchaseRequisitionBudget;
        DateDeb: Date;
        DateFin: Date;
        HaveLines: Boolean;
        PurchLine: Record "Purchase Line";
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        NewAcc: Code[20];
        NewCodeBudget: Code[20];
        GLAcc: Record "G/L Account";
        OldAccAmt: Decimal;
    begin

        GetPeriod(PurchaseH."Document Date", DateDeb, DateFin);
        //MESSAGE('%1 - %2',DateDeb,DateFin);

        CLEAR(BudgetLine);
        BudgetLine.SETRANGE("Document Type", PurchaseH."Document Type");
        BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
        BudgetLine.DELETEALL;

        PurchLine.RESET;
        PurchLine.SETCURRENTKEY(Afk_PurchaseAccount, "Shortcut Dimension 1 Code");
        PurchLine.SETRANGE("Document Type", PurchaseH."Document Type");
        PurchLine.SETRANGE("Document No.", PurchaseH."No.");
        IF PurchLine.FINDSET THEN
            OldAcc := PurchLine.Afk_PurchaseAccount;
        OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
        REPEAT

            NewAcc := PurchLine.Afk_PurchaseAccount;
            NewCodeBudget := PurchLine."Shortcut Dimension 1 Code";
            CheckData(NewAcc, NewCodeBudget, PurchLine."Line No.");

            IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewCodeBudget)) THEN BEGIN
                CLEAR(BudgetLine);
                BudgetLine."Document Type" := PurchaseH."Document Type";
                BudgetLine."Document No." := PurchaseH."No.";
                BudgetLine."G/L Account No" := OldAcc;
                BudgetLine."Dimension Code 1" := OldCodeBudget;
                IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

                CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

                IF OldAcc <> '' THEN BudgetLine.INSERT;
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

            CalcValuesBudget(BudgetLine, PurchaseH."Document Date", PurchaseH."No.", OldAcc, OldCodeBudget);

            //IF (BudgetLine."Remaining Amount"<0) THEN BudgetLine."Remaining Amount":=0;

            IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;
    end;

    procedure CreatePurchaseBudgetLinesFromReq(PurchaseH: Record AfkPurchaseRequisition)
    var
        BudgetLine: Record AfkPurchaseRequisitionBudget;
        DateDeb: Date;
        DateFin: Date;
        HaveLines: Boolean;
        PurchLine: Record "Purchase Line";
        OldAcc: Code[20];
        OldCodeBudget: Code[20];
        NewAcc: Code[20];
        NewCodeBudget: Code[20];
        GLAcc: Record "G/L Account";
        OldAccAmt: Decimal;
        CreationDate: Date;
    begin

        CreationDate := DT2Date(PurchaseH.SystemCreatedAt);

        GetPeriod(CreationDate, DateDeb, DateFin);
        //MESSAGE('%1 - %2',DateDeb,DateFin);

        AddOnSetup.GET;
        AddOnSetup.TESTFIELD(AddOnSetup."Default Budget Code");

        CLEAR(BudgetLine);
        BudgetLine.SETRANGE("Document Type", BudgetLine."Document Type"::Requisition);
        BudgetLine.SETRANGE("Document No.", PurchaseH."No.");
        BudgetLine.DELETEALL;

        PurchLine.RESET;
        PurchLine.SETCURRENTKEY("Afk_PurchaseAccount", "Shortcut Dimension 1 Code");
        //PurchLine.SETRANGE("Document Type",BudgetLine."Document Type"::Requisition);
        PurchLine.SETRANGE("Document No.", PurchaseH."No.");
        IF PurchLine.FINDSET THEN
            OldAcc := PurchLine."Afk_PurchaseAccount";
        OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
        REPEAT
            NewAcc := PurchLine."Afk_PurchaseAccount";
            NewCodeBudget := PurchLine."Shortcut Dimension 1 Code";
            CheckData(NewAcc, NewCodeBudget, PurchLine."Line No.");

            IF ((OldAcc <> NewAcc) OR (OldCodeBudget <> NewCodeBudget)) THEN BEGIN
                CLEAR(BudgetLine);
                BudgetLine."Document Type" := BudgetLine."Document Type"::Requisition;
                BudgetLine."Document No." := PurchaseH."No.";
                BudgetLine."G/L Account No" := OldAcc;
                BudgetLine."Dimension Code 1" := OldCodeBudget;
                IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;

                BudgetLine."Document Amount" := OldAccAmt;

                CalcValuesBudget(BudgetLine, CreationDate, PurchaseH."No.", OldAcc, OldCodeBudget);

                IF OldAcc <> '' THEN BudgetLine.INSERT;
                OldAcc := PurchLine."Afk_PurchaseAccount";
                OldCodeBudget := PurchLine."Shortcut Dimension 1 Code";
                //OldAccAmt:=ConvertAmtLCY(PurchaseH."Creation Date",PurchLine."Line Amount",PurchaseH."Currency Code");
            END ELSE BEGIN
                //OldAccAmt := OldAccAmt + ConvertAmtLCY(PurchaseH."Document Date",PurchLine."Line Amount",PurchaseH."Currency Code");
            END;

            HaveLines := TRUE;
        UNTIL PurchLine.NEXT = 0;


        //Derniere ligne
        IF HaveLines THEN BEGIN
            CLEAR(BudgetLine);
            BudgetLine."Document Type" := BudgetLine."Document Type"::Requisition;
            BudgetLine."Document No." := PurchaseH."No.";
            BudgetLine."G/L Account No" := OldAcc;

            IF GLAcc.GET(OldAcc) THEN BudgetLine."G/L Account Name" := GLAcc.Name;
            BudgetLine."Dimension Code 1" := OldCodeBudget;
            BudgetLine."Commitment Amount" := GetPrecommitmentAmt(OldAcc, OldCodeBudget, PurchaseH."No.", DateDeb, DateFin);
            BudgetLine."Document Amount" := OldAccAmt;

            CalcValuesBudget(BudgetLine, CreationDate, PurchaseH."No.", OldAcc, OldCodeBudget);

            IF OldAcc <> '' THEN BudgetLine.INSERT;
        END;

    end;

    local procedure ConvertAmtLCY(PostingDate: Date; ForeignAmt: Decimal; CurrencyCode: Code[10]): Decimal
    var
        Currency: Record "Currency";
        CurrencyFactor: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
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


    local procedure RefreshRemainingQtyReq(var PurchReq: Record AfkPurchaseRequisition)
    var
        PurchReqLine: Record AfkPurchaseRequisitionLine;
        QtyInOrder: Decimal;
        QtyInvoiced: Decimal;
        PartiallyProcess: Boolean;
        TotallyProcess: Boolean;
    begin
        PartiallyProcess := FALSE;
        TotallyProcess := TRUE;

        PurchReqLine.RESET;
        PurchReqLine.SETRANGE(PurchReqLine."Document No.", PurchReq."No.");
        IF PurchReqLine.FINDSET THEN
            REPEAT

                IF PurchReqLine.Type <> PurchReqLine.Type::" " THEN BEGIN

                    PurchReqLine."Ordered Quantity (Base)" := GetInvoicedQtyReqLine(PurchReq."No.", PurchReqLine."Line No.") +
                      GetInOrderQtyReqLine(PurchReq."No.", PurchReqLine."Line No.");

                    PurchReqLine."Remaining Quantity (Base)" := PurchReqLine."Quantity (Base)" - PurchReqLine."Ordered Quantity (Base)";

                    PurchReqLine.MODIFY;

                    IF PurchReqLine."Ordered Quantity (Base)" <> 0 THEN
                        PartiallyProcess := TRUE;

                    IF PurchReqLine."Remaining Quantity (Base)" <> 0 THEN
                        TotallyProcess := FALSE;

                END;

            UNTIL PurchReqLine.NEXT = 0;

        IF TotallyProcess THEN BEGIN
            PurchReq."Processing Status" := PurchReq."Processing Status"::"Totally processed";
            PurchReq.MODIFY;
        END ELSE BEGIN
            IF PartiallyProcess THEN BEGIN
                PurchReq."Processing Status" := PurchReq."Processing Status"::"Partially processed";
                PurchReq.MODIFY;
            END;
        END;
    end;

    procedure RefreshRemainingQtyReqByCode(PurchReqCode: Code[20])
    var
        PurchReq: Record AfkPurchaseRequisition;
    begin
        IF PurchReq.GET(PurchReqCode) THEN
            RefreshRemainingQtyReq(PurchReq);
    end;

    local procedure GetInvoicedQtyReqLine(DocNo: Code[20]; LineNo: Integer) ReturnQty: Decimal
    var
        PurchInvLine: Record "Purchase Line";
    begin
        PurchInvLine.RESET;
        PurchInvLine.SETCURRENTKEY(Afk_PurchReqNo, Afk_PurchReqLineNo);
        PurchInvLine.SETRANGE(Afk_PurchReqNo, DocNo);
        PurchInvLine.SETRANGE(Afk_PurchReqLineNo, LineNo);
        IF PurchInvLine.FINDSET THEN
            REPEAT
                ReturnQty := ReturnQty + PurchInvLine."Quantity (Base)";
            UNTIL PurchInvLine.NEXT = 0;

        EXIT(ReturnQty);
    end;

    local procedure GetInOrderQtyReqLine(DocNo: Code[20]; LineNo: Integer) ReturnQty: Decimal
    var
        PurchLine1: Record "Purchase Line";
    begin
        PurchLine1.RESET;
        PurchLine1.SETCURRENTKEY(Afk_PurchReqNo, Afk_PurchReqLineNo);
        PurchLine1.SETRANGE(PurchLine1."Document Type", PurchLine1."Document Type"::Order);
        PurchLine1.SETRANGE(Afk_PurchReqNo, DocNo);
        PurchLine1.SETRANGE(Afk_PurchReqLineNo, LineNo);
        IF PurchLine1.FINDSET THEN
            REPEAT
                ReturnQty := ReturnQty + PurchLine1."Quantity (Base)" - PurchLine1."Qty. Invoiced (Base)";
            UNTIL PurchLine1.NEXT = 0;

        EXIT(ReturnQty);
    end;

    procedure SolderCdeAchat(VAR PurchH: Record "Purchase Header")
    var
        ReleaseMgt: Codeunit "Release Purchase Document";
        PurchLine1: Record "Purchase Line";
    begin
        IF NOT CONFIRM(STRSUBSTNO(Text014, PurchH."No.")) THEN EXIT;
        ReleaseMgt.PerformManualReopen(PurchH);



        PurchLine1.RESET;
        PurchLine1.SETRANGE("Document Type", PurchLine1."Document Type"::Order);
        PurchLine1.SETRANGE("Document No.", PurchH."No.");
        IF PurchLine1.FINDSET THEN
            REPEAT

                IF PurchLine1."Quantity Invoiced" <> PurchLine1."Quantity Received" THEN
                    ERROR(Text013, PurchLine1."No.");

                PurchLine1.VALIDATE(PurchLine1.Quantity, PurchLine1."Quantity Received");
                PurchLine1.MODIFY;

            UNTIL PurchLine1.NEXT = 0;


        PurchH."Afk_ProcessingStatus" := PurchH.Afk_ProcessingStatus::Closed;
        PurchH.MODIFY;
        ArchiveManagement.ArchPurchDocumentNoConfirm(PurchH);

        //PurchH.AFK_AllowDeletion(TRUE);
        PurchH.DELETE(TRUE);
    end;

    procedure GetFiltreTypeDemandeAchat() Rep: Enum AfkPurchReqType
    var
        UserSetup1: Record "User Setup";
    begin
        UserSetup1.GET(USERID);
        EXIT(UserSetup1.Afk_PRType);
    end;

    procedure GetFiltreTypeCommandeAchat() Rep: Enum AfkPurchOrderType
    var
        UserSetup1: Record "User Setup";
    begin
        UserSetup1.GET(USERID);
        EXIT(UserSetup1.Afk_POType);
    end;

    procedure CheckPurchaseOrderInWflw(PurchOrder: Record "Purchase Header")
    var
        PurchL: Record "Purchase Line";
        Item1: Record Item;
    begin
        IF PurchOrder."Document Type" <> PurchOrder."Document Type"::Order THEN
            EXIT;

        PurchOrder.TESTFIELD(PurchOrder."Buy-from Vendor No.");

        PurchL.RESET;
        PurchL.SETRANGE("Document Type", PurchOrder."Document Type");
        PurchL.SETRANGE("Document No.", PurchOrder."No.");
        IF PurchL.FINDSET THEN
            REPEAT
                IF PurchL.Type <> PurchL.Type::" " THEN BEGIN

                    PurchL.TESTFIELD("No.");
                    PurchL.TESTFIELD("Direct Unit Cost");
                    IF PurchL.Type = PurchL.Type::Item THEN
                        IF Item1.GET(PurchL."No.") THEN
                            IF Item1.Type = Item1.Type::Inventory THEN
                                PurchL.TESTFIELD(PurchL."Location Code");

                END;
            UNTIL PurchL.NEXT = 0;
    end;

    procedure CheckDim(PurchReq: Record AfkPurchaseRequisition)
    var
        PurchReqLine2: Record AfkPurchaseRequisitionLine;
        Item1: Record Item;
    begin
        PurchReqLine2.SETRANGE(PurchReqLine2."Document No.", PurchReq."No.");
        PurchReqLine2.SETFILTER(Type, '<>%1', PurchReqLine2.Type::" ");
        IF PurchReqLine2.FINDSET THEN
            REPEAT
                IF (PurchReqLine2.Quantity <> 0)
                THEN BEGIN
                    CheckDimComb(PurchReqLine2);
                    CheckDimValuePosting(PurchReqLine2, PurchReq);
                END;
            UNTIL PurchReqLine2.NEXT = 0;
    end;

    local procedure CheckDimComb(PurchReqLine: Record AfkPurchaseRequisitionLine)
    var
        PurchReqLine2: Record AfkPurchaseRequisitionLine;

    begin
        IF PurchReqLine."Line No." = 0 THEN
            IF NOT DimMgt.CheckDimIDComb(PurchReqLine."Dimension Set ID") THEN
                ERROR(
                  Text028,
                  'Demande', PurchReqLine."Document No.", DimMgt.GetDimCombErr);

        IF PurchReqLine."Line No." <> 0 THEN
            IF NOT DimMgt.CheckDimIDComb(PurchReqLine."Dimension Set ID") THEN
                ERROR(
                  Text029,
                  'Demande', PurchReqLine."Document No.", PurchReqLine."Line No.", DimMgt.GetDimCombErr);
    end;

    local procedure CheckDimValuePosting(VAR PurchReqLine: Record AfkPurchaseRequisitionLine; PurchReq: Record AfkPurchaseRequisition)
    var
        TableIDArr: Array[10] of Integer;
        NumberArr: Array[10] of Code[10];
    begin
        IF PurchReqLine."Line No." = 0 THEN BEGIN

        END ELSE BEGIN
            TableIDArr[1] := TypeToTableID3(PurchReqLine.Type);
            NumberArr[1] := PurchReqLine."No.";
            IF NOT DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, PurchReqLine."Dimension Set ID") THEN
                ERROR(
                  Text031,
                  'Demande', PurchReqLine."Document No.", PurchReqLine."Line No.", DimMgt.GetDimValuePostingErr);
        END;
    end;

    local procedure TypeToTableID3(Type: Enum "Purchase Line Type"): Integer
    var
        TableIDArr: Array[10] of Integer;
        NumberArr: Array[10] of Code[10];
    begin
        CASE Type OF
            Type::" ":
                EXIT(0);
            Type::"G/L Account":
                EXIT(DATABASE::"G/L Account");
            Type::Item:
                EXIT(DATABASE::Item);
            //Type::Resource:
            //  EXIT(DATABASE::Resource);
            Type::"Fixed Asset":
                EXIT(DATABASE::"Fixed Asset");
            Type::"Charge (Item)":
                EXIT(DATABASE::"Item Charge");
        END;
    end;



    local procedure DDATotalementFacturee(var SRequisition: Record AfkPurchaseRequisition): Boolean
    var
        SRLine: Record AfkPurchaseRequisitionLine;
        QteRestante: Decimal;
    begin
        RefreshRemainingQtyReq(SRequisition);

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                IF SRLine.Type <> SRLine.Type::" " THEN BEGIN

                    QteRestante := QteRestante + UOMMgt.CalcQtyFromBase(SRLine."Quantity (Base)" - SRLine."Ordered Quantity (Base)", SRLine."Qty. per Unit of Measure");

                END;
            UNTIL SRLine.NEXT = 0;
        EXIT(QteRestante = 0);
    end;


    var
        SRDoc: Record AfkPurchaseRequisition;
        UOMMgt: Codeunit "Unit of Measure Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        FASetup: Record "FA Setup";
        AddOnSetup: Record AfkSetup;
        DimMgt: Codeunit DimensionManagement;
        Text002: Label 'The document has no lines';
        Text032: Label 'This purchase requisition has already been completely processed.';
        Text010: Label 'Do you want to close the purchasing document?';
        Text008: Label 'Posting groups not defined on command line %1 - %2 - (%3 - %4)';
        Text009: Label 'Posting groups not defined on purchase requisition line %1 - %2';
        Text011: Label 'Purchase account is invalid on line %1';
        Text014: Label 'Would you like to close this purchase order: %1?';
        Text013: Label 'You cannot close this order because the quantity received has not been fully invoiced for item %1';

        Text012: Label 'Budget code not filled in on line %1';
        Text028: Label 'The dimension combination used in %1 %2 is blocked. %3';
        Text029: Label 'The dimension combination used in %1 %2, row no. %3, is blocked. %4';
        Text031: Label 'The dimensions used in %1 %2, line n° %3, are invalid. %4';

}