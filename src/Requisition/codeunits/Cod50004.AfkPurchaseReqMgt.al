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
        SRLine.SETRANGE(SRLine."Document Type", SRDoc."Document Type");
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

        SRDoc.GET(SRDoc."Document Type"::Requisition, Devis.Afk_RequisitionCode);
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
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::Requisition);
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
        SRLine.SETRANGE("Document Type", SRequisition."Document Type");
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                //IF SRLine."No."<>'' THEN
                //  SRLine.TESTFIELD(SRLine."Code Nature");
                PostedLineServR.TRANSFERFIELDS(SRLine);
                PostedLineServR.INSERT;
            UNTIL SRLine.NEXT = 0;



        SRLine.RESET;
        SRLine.SETRANGE("Document Type", SRequisition."Document Type");
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        SRLine.DELETEALL;

        SRequisition.DELETELINKS;
        SRequisition.DELETE(TRUE);
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
        PurchReqLine.SETRANGE(PurchReqLine."Document Type", PurchReq."Document Type");
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
        IF PurchReq.GET(PurchReq."Document Type"::Requisition, PurchReqCode) THEN
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
        SRLine.SETRANGE(SRLine."Document Type", SRequisition."Document Type");
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

        Text014: Label 'Would you like to close this purchase order: %1?';
        Text013: Label 'You cannot close this order because the quantity received has not been fully invoiced for item %1';


        Text028: Label 'The dimension combination used in %1 %2 is blocked. %3';
        Text029: Label 'The dimension combination used in %1 %2, row no. %3, is blocked. %4';
        Text031: Label 'The dimensions used in %1 %2, line n° %3, are invalid. %4';

}