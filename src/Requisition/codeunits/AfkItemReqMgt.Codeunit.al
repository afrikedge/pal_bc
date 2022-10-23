codeunit 50012 AfkItemReqMgt
{


    procedure PostItemRequisition(var SRequisition: Record AfkDocRequisition)
    var
        SRLine: Record AfkDocRequisitionLine;
    begin

        BudgetControl.CreatePurchaseBudgetLines_ItemReq(SRequisition, true);
        SRequisition.TestField(SRequisition.Status, SRequisition.Status::Released);

        if not CONFIRM(STRSUBSTNO(Text034, SRequisition."No.")) then exit;

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                PostItemRequisitionEntries(SRequisition, SRLine);
            UNTIL SRLine.NEXT = 0;


        DeleteAndArchiveItemRequisition(SRequisition, false);

    end;

    local procedure PostItemRequisitionEntries(var ItemRequisition: Record AfkDocRequisition;
        ItemReqLine: Record AfkDocRequisitionLine)
    var
        Item1: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ItemJnlPostLine2: Codeunit "Item Jnl.-Post Line";
        SourceCode: Code[20];
    begin

        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup."Item Journal";

        IF ItemReqLine.Quantity = 0 THEN EXIT;

        ItemReqLine.TestField("No.");
        ItemReqLine.TestField("Location Code");
        ItemReqLine.TestField(Quantity);
        ItemReqLine.TestField("Unit of Measure Code");

        Item1.GET(ItemReqLine."No.");

        ItemJnlLine.INIT;
        //ItemJnlLine."Adjustment Type" := AdjustType;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
        ItemJnlLine."Posting Date" := ItemRequisition."Posting Date";
        ItemJnlLine."Document Date" := ItemRequisition."Document Date";
        ItemJnlLine."Document No." := ItemRequisition."No.";
        ItemJnlLine."External Document No." := ItemRequisition."External Doc No";

        ItemJnlLine.VALIDATE("Item No.", Item1."No.");
        ItemJnlLine.Description := ItemReqLine.Description;

        ItemJnlLine."Dimension Set ID" := ItemReqLine."Dimension Set ID";
        ItemJnlLine.VALIDATE("Location Code", ItemReqLine."Location Code");

        ItemJnlLine.VALIDATE(Quantity, ABS(ItemReqLine.Quantity));
        ItemJnlLine.VALIDATE("Unit of Measure Code", ItemReqLine."Unit of Measure Code");
        ItemJnlLine."Invoiced Quantity" := ABS(ItemReqLine.Quantity);

        ItemJnlLine."Source Code" := SourceCode;
        ItemJnlLine."Gen. Prod. Posting Group" := Item1."Gen. Prod. Posting Group";

        //IF DimSetIdOr = 0 THEN
        //    ItemJnlLine.AFK_SetDimensionsItem(Item1."No."); //JN120118********************

        ItemJnlPostLine2.RunWithCheck(ItemJnlLine);

    end;

    local procedure DeleteAndArchiveItemRequisition(var SRequisition: Record AfkDocRequisition; IsClosed: Boolean)
    var
        SRLine: Record AfkDocRequisitionLine;
        PostedLineServR: Record AfkPostDocRequisitionLine;
        PostedServiceRequisition: Record AfkPostedDocRequisition;
    begin
        //Archiver la demande de service
        PostedServiceRequisition.INIT;
        PostedServiceRequisition.TRANSFERFIELDS(SRequisition);

        PostedServiceRequisition."Created Doc Type" := PostedServiceRequisition."Created Doc Type"::Commande;
        // PostedServiceRequisition."Created Doc Code" := CodeDocCree;

        if IsClosed Then begin
            PostedServiceRequisition."Afk_ProcessingStatus" := PostedServiceRequisition.Afk_ProcessingStatus::Closed;
            //PostedServiceRequisition.Status := PostedServiceRequisition.Status::Validated;
            PostedServiceRequisition."Closed Date" := TODAY;
            PostedServiceRequisition."Closed By" := USERID;
        end;

        PostedServiceRequisition.COPYLINKS(SRequisition);
        PostedServiceRequisition.INSERT;


        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                //IF SRLine."No."<>'' THEN
                //  SRLine.TESTFIELD(SRLine."Code Nature");
                PostedLineServR.TRANSFERFIELDS(SRLine);
                PostedLineServR.INSERT;
            UNTIL SRLine.NEXT = 0;



        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE(SRLine."Document No.", SRequisition."No.");
        SRLine.DELETEALL;

        SRequisition.PerformManualReOpen();
        SRequisition.DELETELINKS;
        SRequisition.DELETE(TRUE);

    end;

    procedure CancelItemRequisition(var PurchH: Record AfkDocRequisition)
    var

    begin

        if not CONFIRM(STRSUBSTNO(Text033, PurchH."No.")) then exit;
        PurchH.PerformManualReOpen();
        DeleteAndArchiveItemRequisition(PurchH, true);
        PurchH.DELETE(true);

    end;


    var
        BudgetControl: Codeunit AfkBudgetControl;
        Text033: Label 'Would you like to close this Item requisition: %1?';
        Text034: Label 'Would you like to post this Item requisition: %1?';
}
