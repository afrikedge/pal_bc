codeunit 50004 AfkPurchaseReqMgt
{
    trigger OnRun()
    begin
    end;

    procedure CreateOpenNewOffer()
    var
        SRLine: Record AfkDocRequisitionLine;
        PurchQuoteH: Record "Purchase Header";
        QuoteCard: Page "Purchase Quote";

    begin
        SRDoc.TESTFIELD(SRDoc.Status, SRDoc.Status::Released);

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRDoc."Document Type");
        SRLine.SETRANGE(SRLine."Document No.", SRDoc."No.");
        if SRLine.ISEMPTY then ERROR(Text002);

        if DDATotalementFacturee(SRDoc) then
            ERROR(Text032);


        CLEAR(PurchQuoteH);
        PurchQuoteH."Document Type" := PurchQuoteH."Document Type"::Quote;
        PurchQuoteH.Afk_RequisitionCode := SRDoc."No.";
        PurchQuoteH."Requested Receipt Date" := SRDoc."Requested Receipt Date";
        PurchQuoteH."Afk_PRType" := SRDoc."PR Type";
        PurchQuoteH."Afk_POType" := SRDoc."PO Type";
        PurchQuoteH."Afk_PRDescription" := SRDoc.Description;
        PurchQuoteH."No." := '';
        PurchQuoteH.INSERT(true);


        QuoteCard.SETTABLEVIEW(PurchQuoteH);
        QuoteCard.SETRECORD(PurchQuoteH);
        QuoteCard.RUN;
    end;

    procedure CreateLinesOffer(Devis: Record "Purchase Header")
    var
        SRDoc: Record "AfkDocRequisition";
        SRLine: Record AfkDocRequisitionLine;
        PurchLine: Record "Purchase Line";
        QteRestante: Decimal;
        LineNo: Integer;

    begin
        if Devis."Document Type" <> Devis."Document Type"::Quote then exit;
        if Devis.Afk_RequisitionCode = '' then exit;

        SRDoc.GET(SRDoc."Document Type"::Requisition, Devis.Afk_RequisitionCode);
        Devis."Afk_BudgetCode" := SRDoc."Budget Code";
        Devis."Afk_PurchaseType" := SRDoc."Purchase Type";
        //Devis."Purchaser Code" := SRDoc."Purchaser Code";

        //IF Devis."Purchaser Code" = '' THEN
        //    Devis."Purchaser Code" := GetUserPurchaseCode(USERID);

        //Devis.Description := SRDoc.Description;
        Devis.VALIDATE("Shortcut Dimension 1 Code", SRDoc."Shortcut Dimension 1 Code");
        Devis.VALIDATE("Shortcut Dimension 2 Code", SRDoc."Shortcut Dimension 2 Code");
        Devis."Dimension Set ID" := SRDoc."Dimension Set ID";
        Devis.VALIDATE("Expected Receipt Date", SRDoc."Requested Receipt Date");

        Devis.MODIFY(true);
        Devis.TESTFIELD(Devis."Buy-from Vendor No.");

        PurchLine.RESET();
        PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Quote);
        PurchLine.SETRANGE(PurchLine."Document No.", Devis."No.");
        if not PurchLine.ISEMPTY then exit;

        LineNo := 10000;
        SRLine.RESET();
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::Requisition);
        SRLine.SETRANGE(SRLine."Document No.", Devis.Afk_RequisitionCode);
        if SRLine.FINDSET() then
            repeat
                PurchLine.INIT();
                PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                PurchLine."Document No." := Devis."No.";
                PurchLine."Line No." := LineNo;
                LineNo := LineNo + 10000;

                //PurchLine.Type:=SRLine.Type;
                if SRLine.Type = SRLine.Type::" " then PurchLine.Type := PurchLine.Type::" ";
                if SRLine.Type = SRLine.Type::Item then PurchLine.Type := PurchLine.Type::Item;
                if SRLine.Type = SRLine.Type::"Fixed Asset" then PurchLine.Type := PurchLine.Type::"Fixed Asset";
                if SRLine.Type = SRLine.Type::"G/L Account" then PurchLine.Type := PurchLine.Type::"G/L Account";
                if SRLine.Type = SRLine.Type::"Charge (Item)" then PurchLine.Type := PurchLine.Type::"Charge (Item)";

                if SRLine.Type <> SRLine.Type::" " then
                    PurchLine.VALIDATE("No.", SRLine."No.");
                PurchLine.Description := SRLine.Description;
                PurchLine."Dimension Set ID" := SRLine."Dimension Set ID";

                PurchLine.Afk_PurchReqNo := SRLine."Document No.";
                PurchLine.Afk_PurchReqLineNo := SRLine."Line No.";

                if SRLine.Type <> SRLine.Type::" " then begin
                    QteRestante := UOMMgt.CalcQtyFromBase(SRLine."Quantity (Base)" - SRLine."Ordered Quantity (Base)", SRLine."Qty. per Unit of Measure");
                    PurchLine.VALIDATE(Quantity, QteRestante);
                    PurchLine.VALIDATE("Unit of Measure Code", SRLine."Unit of Measure Code");
                    PurchLine.VALIDATE("Direct Unit Cost", 0);
                end;
                //PurchLine.VALIDATE("Direct Unit Cost",SRLine."Prix Unitaire");
                //PurchLine."Code Nature":=SRLine."Nature code";
                //PurchLine."Code projet":=SRLine."Project Code";
                //PurchLine."Serial No." := SRLine."Serial No.";
                //PurchLine."Item Ref" := SRLine."Item Ref";
                if (SRLine.Type = SRLine.Type::" ") then
                    PurchLine.INSERT(true)
                else
                    if QteRestante > 0 then
                        PurchLine.INSERT(true);

            until SRLine.NEXT() = 0;

    end;

    procedure CloturerDemande(var SRequisition: Record "AfkDocRequisition";
            CodeDocCree: Code[20]; TypeDocCree: Option Commande,Contrat;
            CodeOffreRetenue: Code[20])
    var
        SRLine: Record AfkDocRequisitionLine;
        PostedLineServR: Record AfkPostDocRequisitionLine;
        PostedServiceRequisition: Record "AfkPostedDocRequisition";
        EnteteOffre: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
    begin

        SRequisition.TESTFIELD(Status, SRequisition.Status::Released);

        if not CONFIRM(Text010) then exit;

        //Archiver toutes les offres fournisseur

        EnteteOffre.RESET();
        EnteteOffre.SETRANGE(EnteteOffre."Document Type", EnteteOffre."Document Type"::Quote);
        EnteteOffre.SETRANGE(EnteteOffre.Afk_RequisitionCode, SRequisition."No.");
        if EnteteOffre.FINDSET then
            repeat
                //IF (EnteteOffre."No."<>CodeOffreRetenue) THEN
                //  ArchiveMgt.StorePurchDocument(EnteteOffre,FALSE);
                ArchiveManagement.ArchPurchDocumentNoConfirm(EnteteOffre);

                //Supprimer les autres offres de service
                if (EnteteOffre."No." <> CodeOffreRetenue) then begin

                    PurchQuoteLine.RESET;
                    PurchQuoteLine.SETRANGE("Document Type", PurchQuoteLine."Document Type"::Quote);
                    PurchQuoteLine.SETRANGE("Document No.", EnteteOffre."No.");
                    PurchQuoteLine.DELETEALL;

                    EnteteOffre.DELETELINKS;
                    EnteteOffre.DELETE(true);
                end;

            until EnteteOffre.NEXT = 0;



        //Archiver la demande de service
        PostedServiceRequisition.INIT;
        PostedServiceRequisition.TRANSFERFIELDS(SRequisition);

        PostedServiceRequisition."Created Doc Type" := PostedServiceRequisition."Created Doc Type"::Commande;
        PostedServiceRequisition."Created Doc Code" := CodeDocCree;
        PostedServiceRequisition.Status := PostedServiceRequisition.Status::Released;
        PostedServiceRequisition."Closed Date" := TODAY;
        PostedServiceRequisition."Closed By" := CopyStr(USERID(), 1, MaxStrLen(PostedServiceRequisition."Closed By"));

        PostedServiceRequisition.COPYLINKS(SRequisition);
        PostedServiceRequisition.INSERT();


        SRLine.RESET;
        SRLine.SETRANGE("Document Type", SRequisition."Document Type");
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        if SRLine.FINDSET then
            repeat
                //IF SRLine."No."<>'' THEN
                //  SRLine.TESTFIELD(SRLine."Code Nature");
                PostedLineServR.TRANSFERFIELDS(SRLine);
                PostedLineServR.INSERT;
            until SRLine.NEXT = 0;



        SRLine.RESET;
        SRLine.SETRANGE("Document Type", SRequisition."Document Type");
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        SRLine.DELETEALL;

        SRequisition.DELETELINKS;
        SRequisition.DELETE(true);
    end;



    local procedure RefreshRemainingQtyReq(var PurchReq: Record "AfkDocRequisition")
    var
        PurchReqLine: Record AfkDocRequisitionLine;
        PartiallyProcess: Boolean;
        TotallyProcess: Boolean;
        QtyInOrder: Decimal;
        QtyInvoiced: Decimal;
    begin
        PartiallyProcess := false;
        TotallyProcess := true;

        PurchReqLine.RESET;
        PurchReqLine.SETRANGE(PurchReqLine."Document Type", PurchReq."Document Type");
        PurchReqLine.SETRANGE(PurchReqLine."Document No.", PurchReq."No.");
        if PurchReqLine.FINDSET then
            repeat

                if PurchReqLine.Type <> PurchReqLine.Type::" " then begin

                    PurchReqLine."Ordered Quantity (Base)" := GetInvoicedQtyReqLine(PurchReq."No.", PurchReqLine."Line No.") +
                      GetInOrderQtyReqLine(PurchReq."No.", PurchReqLine."Line No.");

                    PurchReqLine."Remaining Quantity (Base)" := PurchReqLine."Quantity (Base)" - PurchReqLine."Ordered Quantity (Base)";

                    PurchReqLine.MODIFY();

                    if PurchReqLine."Ordered Quantity (Base)" <> 0 then
                        PartiallyProcess := true;

                    if PurchReqLine."Remaining Quantity (Base)" <> 0 then
                        TotallyProcess := false;

                end;

            until PurchReqLine.NEXT() = 0;

        if TotallyProcess then begin
            PurchReq."Processing Status" := PurchReq."Processing Status"::"Totally processed";
            PurchReq.MODIFY();
        end else
            if PartiallyProcess then begin
                PurchReq."Processing Status" := PurchReq."Processing Status"::"Partially processed";
                PurchReq.MODIFY();
            end;

    end;

    procedure RefreshRemainingQtyReqByCode(PurchReqCode: Code[20])
    var
        PurchReq: Record "AfkDocRequisition";
    begin
        if PurchReq.GET(PurchReq."Document Type"::Requisition, PurchReqCode) then
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
        if PurchInvLine.FINDSET then
            repeat
                ReturnQty := ReturnQty + PurchInvLine."Quantity (Base)";
            until PurchInvLine.NEXT = 0;

        exit(ReturnQty);
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
        if PurchLine1.FINDSET then
            repeat
                ReturnQty := ReturnQty + PurchLine1."Quantity (Base)" - PurchLine1."Qty. Invoiced (Base)";
            until PurchLine1.NEXT = 0;

        exit(ReturnQty);
    end;

    procedure SolderCdeAchat(var PurchH: Record "Purchase Header")
    var
        PurchLine1: Record "Purchase Line";
        ReleaseMgt: Codeunit "Release Purchase Document";
    begin
        if not CONFIRM(STRSUBSTNO(Text014, PurchH."No.")) then exit;
        ReleaseMgt.PerformManualReopen(PurchH);



        PurchLine1.RESET();
        PurchLine1.SETRANGE("Document Type", PurchLine1."Document Type"::Order);
        PurchLine1.SETRANGE("Document No.", PurchH."No.");
        if PurchLine1.FINDSET() then
            repeat

                if PurchLine1."Quantity Invoiced" <> PurchLine1."Quantity Received" then
                    ERROR(Text013, PurchLine1."No.");

                PurchLine1.VALIDATE(PurchLine1.Quantity, PurchLine1."Quantity Received");
                PurchLine1.MODIFY();

            until PurchLine1.NEXT() = 0;


        PurchH."Afk_ProcessingStatus" := PurchH.Afk_ProcessingStatus::Closed;
        PurchH.MODIFY();
        // ArchiveManagement.ArchPurchDocumentNoConfirm(PurchH);

        //PurchH.AFK_AllowDeletion(TRUE);
        PurchH.DELETE(true);
    end;

    procedure SolderDemandeAchat(var PurchH: Record "Purchase Header")
    var
        PurchLine1: Record "Purchase Line";
        ReleaseMgt: Codeunit "Release Purchase Document";
    begin
        if not CONFIRM(STRSUBSTNO(Text014, PurchH."No.")) then exit;
        ReleaseMgt.PerformManualReopen(PurchH);



        // PurchLine1.RESET();
        // PurchLine1.SETRANGE("Document Type", PurchLine1."Document Type"::Order);
        // PurchLine1.SETRANGE("Document No.", PurchH."No.");
        // if PurchLine1.FINDSET() then
        //     repeat

        //         if PurchLine1."Quantity Invoiced" <> PurchLine1."Quantity Received" then
        //             ERROR(Text013, PurchLine1."No.");

        //         PurchLine1.VALIDATE(PurchLine1.Quantity, PurchLine1."Quantity Received");
        //         PurchLine1.MODIFY();

        //     until PurchLine1.NEXT() = 0;


        PurchH."Afk_ProcessingStatus" := PurchH.Afk_ProcessingStatus::Closed;
        PurchH.MODIFY();
        // ArchiveManagement.ArchPurchDocumentNoConfirm(PurchH);

        //PurchH.AFK_AllowDeletion(TRUE);
        PurchH.DELETE(true);
    end;



    procedure GetFiltreTypeDemandeAchat() Rep: Enum AfkPurchReqType
    var
        UserSetup1: Record "User Setup";
    begin
        UserSetup1.GET(USERID);
        exit(UserSetup1.Afk_PRType);
    end;

    procedure GetFiltreTypeCommandeAchat() Rep: Enum AfkPurchOrderType
    var
        UserSetup1: Record "User Setup";
    begin
        UserSetup1.GET(USERID);
        exit(UserSetup1.Afk_POType);
    end;

    procedure CheckPurchaseOrderInWflw(PurchOrder: Record "Purchase Header")
    var
        Item1: Record Item;
        PurchL: Record "Purchase Line";
    begin
        if PurchOrder."Document Type" <> PurchOrder."Document Type"::Order then
            exit;

        PurchOrder.TESTFIELD(PurchOrder."Buy-from Vendor No.");

        PurchL.RESET;
        PurchL.SETRANGE("Document Type", PurchOrder."Document Type");
        PurchL.SETRANGE("Document No.", PurchOrder."No.");
        if PurchL.FINDSET then
            repeat
                if PurchL.Type <> PurchL.Type::" " then begin

                    PurchL.TESTFIELD("No.");
                    PurchL.TESTFIELD("Direct Unit Cost");
                    if PurchL.Type = PurchL.Type::Item then
                        if Item1.GET(PurchL."No.") then
                            if Item1.Type = Item1.Type::Inventory then
                                PurchL.TESTFIELD(PurchL."Location Code");

                end;
            until PurchL.NEXT = 0;
    end;

    procedure CheckDim(PurchReq: Record "AfkDocRequisition")
    var
        PurchReqLine2: Record AfkDocRequisitionLine;
        Item1: Record Item;
    begin
        PurchReqLine2.SETRANGE(PurchReqLine2."Document No.", PurchReq."No.");
        PurchReqLine2.SETFILTER(Type, '<>%1', PurchReqLine2.Type::" ");
        if PurchReqLine2.FINDSET then
            repeat
                if (PurchReqLine2.Quantity <> 0)
                then begin
                    CheckDimComb(PurchReqLine2);
                    CheckDimValuePosting(PurchReqLine2, PurchReq);
                end;
            until PurchReqLine2.NEXT = 0;
    end;

    internal procedure InitPurchLineType(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchLine.Type := PurchLine.Type::Item;
        IsHandled := true;
    end;

    internal procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        AddOnSetup.Get();
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote)
                or (IsPODocument(PurchaseHeader)) then begin
            AddOnSetup.TestField("PR Max Value");
            PurchaseHeader.CalcFields("Amount Including VAT");
            if (PurchaseHeader."Amount Including VAT") > AddOnSetup."PR Max Value" then
                Error(PRLimitAmountErr, AddOnSetup."PR Max Value");
        end;
        if ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order)
         and (PurchaseHeader.Afk_CommitmentType = PurchaseHeader.Afk_CommitmentType::"Order letter")) then begin
            AddOnSetup.TestField("OrderLetter Max Value");
            PurchaseHeader.CalcFields("Amount Including VAT");
            if (PurchaseHeader."Amount Including VAT") > AddOnSetup."OrderLetter Max Value" then
                Error(ORderLetterLimitAmountErr, AddOnSetup."OrderLetter Max Value");
        end;

        BudgetControl.CreatePurchaseBudgetLines(PurchaseHeader, true);
        PurchaseHeader.Afk_ReleaseDate := Today;


    end;

    local procedure IsPODocument(PurchaseHeader: Record "Purchase Header"): Boolean
    begin
        exit((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote) and
        (PurchaseHeader.Afk_CommitmentType = PurchaseHeader.Afk_CommitmentType::"Purchase order"));
    end;


    internal procedure OnBeforeOnDeletePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        Budgetline: Record AfkDocRequisitionBudget;
    begin

        PurchSetup.Get();
        Budgetline.Reset();
        Budgetline.SetRange("Document Type", PurchaseHeader."Document Type");
        Budgetline.SetRange("Document No.", PurchaseHeader."No.");
        Budgetline.DeleteAll();

        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote) then
            if (PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Never) then
                ArchiveManagement.ArchPurchDocumentNoConfirm(PurchaseHeader);

        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then
            if (not PurchSetup."Archive Orders") then
                ArchiveManagement.ArchPurchDocumentNoConfirm(PurchaseHeader);
    end;

    internal procedure OnAfterInitPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if (UserSetup.Afk_DefaultTask <> '') then
            if (PurchaseHeader."Shortcut Dimension 1 Code" = '') then
                PurchaseHeader."Shortcut Dimension 1 Code" := UserSetup.Afk_DefaultTask;
    end;

    internal procedure OnBeforePrintPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    begin
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then
            PurchaseHeader.TestField(PurchaseHeader.Status, PurchaseHeader.Status::Released);
    end;

    internal procedure OnBeforeConfirmDeletion(var PurchaseHeader: Record "Purchase Header")
    begin
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) then
            Error(DeletionErr);
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote) then
            Error(DeletionErr);
    end;

    internal procedure OnAfterAssignFieldsForNo(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    begin
        //PurchLine.Afk_PurchaseAccount := BudgetControl.GetPurchAcc(PurchLine);
        //if (PurchLine."Shortcut Dimension 1 Code" = '') then
        //PurchLine.Validate("Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 1 Code");
        //PurchLine.Modify();
    end;

    internal procedure OnBeforeDeletePurchQuote_CreateOrder(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        QuotePurchHeader.TestField(QuotePurchHeader.Status, QuotePurchHeader.Status::Released);
        QuotePurchHeader.Afk_OrderNoCreated := OrderPurchHeader."No.";
        QuotePurchHeader.Afk_OrderCreationDate := Today;
        ArchiveManagement.ArchPurchDocumentNoConfirm(QuotePurchHeader);
    end;

    internal procedure OnAfterInsertAllPurchOrderLines(var PurchOrderLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
        // if (PurchOrderLine.FindFirst()) then begin
        //     PurchQuoteHeader.Afk_OrderNoCreated := PurchOrderLine."Document No.";
        //     PurchQuoteHeader.Afk_OrderCreationDate := Today;
        //     PurchQuoteHeader.Modify();
        // end;
    end;

    internal procedure OnCreatePurchHeaderOnBeforeInitRecord_CreateOrder(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
        PurchOrderHeader.Afk_CommitmentType := PurchOrderHeader.Afk_CommitmentType::"Purchase order";
    end;

    internal procedure OnAfterInsertVendorOnPurchase(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.Afk_IR_Pourcent := Vendor.Afk_IR_Pourcent;
        PurchaseHeader.Afk_TSR_Pourcent := Vendor.Afk_TSR_Pourcent;
    end;

    internal procedure CheckBudgetOnLineUpdate(var PurchaseLine: Record "Purchase Line")
    var
        Header: Record "Purchase Header";
    begin
        Header := PurchaseLine.GetPurchHeader();
        BudgetControl.CreatePurchaseBudgetLines(Header, true);
    end;

    local procedure CheckDimComb(PurchReqLine: Record AfkDocRequisitionLine)
    var
        PurchReqLine2: Record AfkDocRequisitionLine;

    begin
        if PurchReqLine."Line No." = 0 then
            if not DimMgt.CheckDimIDComb(PurchReqLine."Dimension Set ID") then
                ERROR(
                  Text028,
                  'Demande', PurchReqLine."Document No.", DimMgt.GetDimCombErr);

        if PurchReqLine."Line No." <> 0 then
            if not DimMgt.CheckDimIDComb(PurchReqLine."Dimension Set ID") then
                ERROR(
                  Err029Err,
                  'Demande', PurchReqLine."Document No.", PurchReqLine."Line No.", DimMgt.GetDimCombErr);
    end;

    local procedure CheckDimValuePosting(var PurchReqLine: Record AfkDocRequisitionLine; PurchReq: Record "AfkDocRequisition")
    var
        NumberArr: array[10] of Code[10];
        TableIDArr: array[10] of Integer;
    begin
        if PurchReqLine."Line No." = 0 then begin

        end else begin
            TableIDArr[1] := TypeToTableID3(PurchReqLine.Type);
            NumberArr[1] := PurchReqLine."No.";
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, PurchReqLine."Dimension Set ID") then
                ERROR(
                  Text031,
                  'Demande', PurchReqLine."Document No.", PurchReqLine."Line No.", DimMgt.GetDimValuePostingErr());
        end;
    end;

    local procedure TypeToTableID3(Type: Enum "Purchase Line Type"): Integer
    begin
        case Type of
            Type::" ":
                exit(0);
            Type::"G/L Account":
                exit(DATABASE::"G/L Account");
            Type::Item:
                exit(DATABASE::Item);
            //Type::Resource:
            //  EXIT(DATABASE::Resource);
            Type::"Fixed Asset":
                exit(DATABASE::"Fixed Asset");
            Type::"Charge (Item)":
                exit(DATABASE::"Item Charge");
        end;
    end;



    local procedure DDATotalementFacturee(var SRequisition: Record "AfkDocRequisition"): Boolean
    var
        SRLine: Record AfkDocRequisitionLine;
        QteRestante: Decimal;
    begin
        RefreshRemainingQtyReq(SRequisition);

        SRLine.RESET();
        SRLine.SETRANGE(SRLine."Document Type", SRequisition."Document Type");
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        if SRLine.FINDSET() then
            repeat
                if SRLine.Type <> SRLine.Type::" " then
                    QteRestante := QteRestante + UOMMgt.CalcQtyFromBase(SRLine."Quantity (Base)" - SRLine."Ordered Quantity (Base)", SRLine."Qty. per Unit of Measure");


            until SRLine.NEXT() = 0;
        exit(QteRestante = 0);
    end;

    procedure GetDocumentDates(OrderNo: code[20];
    var ReceiptDate: Date; var InvoiceDate: Date; var PaymentDate: Date)
    var
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        LastPaymentDate: Date;
    begin
        LastPaymentDate := 0D;
        PurchRcptHeader.Reset();
        PurchRcptHeader.SetRange("Order No.", OrderNo);
        if (PurchRcptHeader.FindLast()) then
            ReceiptDate := DT2Date(PurchRcptHeader.SystemCreatedAt);

        PurchInvHeader.Reset();
        PurchInvHeader.SetRange("Order No.", OrderNo);
        if (PurchInvHeader.FindLast()) then
            InvoiceDate := DT2Date(PurchInvHeader.SystemCreatedAt);

        if (PurchInvHeader.FindSet()) then
            repeat
                VendorLedgerEntry.Reset();
                VendorLedgerEntry.SetCurrentKey("Document No.");
                VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
                if (VendorLedgerEntry.FindLast()) then begin
                    DetailedVendorLedgEntry.Reset();
                    DetailedVendorLedgEntry.SetCurrentKey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                    DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                    DetailedVendorLedgEntry.SetRange("Entry Type", DetailedVendorLedgEntry."Entry Type"::Application);
                    if DetailedVendorLedgEntry.FindSet() then
                        repeat
                            if (DetailedVendorLedgEntry."Document Type" = DetailedVendorLedgEntry."Document Type"::Payment) then
                                if (DT2Date(DetailedVendorLedgEntry.SystemCreatedAt) > LastPaymentDate) then
                                    LastPaymentDate := DT2Date(DetailedVendorLedgEntry.SystemCreatedAt);
                        until DetailedVendorLedgEntry.Next() = 0;
                end;
            until PurchInvHeader.Next() = 0;

        PaymentDate := LastPaymentDate;

    end;




    var
        SRDoc: Record "AfkDocRequisition";
        AddOnSetup: Record AfkSetup;
        FASetup: Record "FA Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        BudgetControl: Codeunit AfkBudgetControl;
        ArchiveManagement: Codeunit ArchiveManagement;
        DimMgt: Codeunit DimensionManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        DeletionErr: Label 'You must use the "Close" feature to delete this document';
        Err029Err: Label 'The dimension combination used in %1 %2, row no. %3, is blocked. %4';
        ORderLetterLimitAmountErr: Label 'The limit amount for Order Letter is %1';
        POLimitAmountErr: Label 'The limit amount for purchase commitments is %1';
        PRLimitAmountErr: Label 'The limit amount for purchase requests is %1';
        Text002: Label 'The document has no lines';
        Text010: Label 'Do you want to close the purchasing document?';
        Text013: Label 'You cannot close this order because the quantity received has not been fully invoiced for item %1';
        Text014: Label 'Would you like to close this purchase order: %1?';
        Text028: Label 'The dimension combination used in %1 %2 is blocked. %3';
        Text031: Label 'The dimensions used in %1 %2, line n° %3, are invalid. %4';
        Text032: Label 'This purchase requisition has already been completely processed.';


}
