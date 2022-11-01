codeunit 50012 AfkItemReqMgt
{


    procedure PostNewItemDelivery(var SRequisition: Record AfkDocRequisition)
    var
        SRLine: Record AfkDocRequisitionLine;
        CompletelyDelivered: Boolean;
        RemainingInLine: Decimal;
    begin

        SRequisition.TestField(SRequisition.Status, SRequisition.Status::Released);
        BudgetControl.CreatePurchaseBudgetLines_ItemReq(SRequisition, true);

        if (not QtyToPostExists(SRequisition)) then
            error(Text036);

        if not CONFIRM(STRSUBSTNO(Text034, SRequisition."No.")) then
            exit;

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                RemainingInLine := SRLine.Quantity - SRLine."Whse Delivered Quantity";
                if (SRLine."Whse Quantity To Deliver" > RemainingInLine) then
                    Error(Text035, SRLine."Line No.", RemainingInLine);
            UNTIL SRLine.NEXT = 0;


        CreateWhseDelivery(SRequisition);


        CheckCompletelyDelivered(SRequisition, CompletelyDelivered);

        if (CompletelyDelivered) then
            DeleteAndArchiveItemRequisition(SRequisition, false);

    end;

    local procedure PostItemDeliveryEntries(var ItemRequisition: Record AfkDocRequisition;
        ItemReqLine: Record AfkDocRequisitionLine; QtyToPost: Decimal; PostedNo: Code[20])
    var
        Item1: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ItemJnlPostLine2: Codeunit "Item Jnl.-Post Line";
        SourceCode: Code[20];
    begin

        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup."Item Journal";

        IF QtyToPost = 0 THEN EXIT;

        ItemReqLine.TestField("No.");
        ItemReqLine.TestField("Location Code");
        ItemReqLine.TestField(Quantity);
        //ItemReqLine.TestField(QtyToPost);
        ItemReqLine.TestField("Unit of Measure Code");

        Item1.GET(ItemReqLine."No.");

        ItemJnlLine.INIT;
        //ItemJnlLine."Adjustment Type" := AdjustType;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
        ItemJnlLine."Posting Date" := ItemRequisition."Posting Date";
        ItemJnlLine."Document Date" := ItemRequisition."Document Date";
        ItemJnlLine."Document No." := PostedNo;
        ItemJnlLine."External Document No." := ItemRequisition."No.";

        ItemJnlLine.VALIDATE("Item No.", Item1."No.");
        ItemJnlLine.Description := ItemReqLine.Description;

        ItemJnlLine."Dimension Set ID" := ItemReqLine."Dimension Set ID";
        ItemJnlLine.VALIDATE("Location Code", ItemReqLine."Location Code");

        ItemJnlLine.VALIDATE(Quantity, ABS(QtyToPost));
        ItemJnlLine.VALIDATE("Unit of Measure Code", ItemReqLine."Unit of Measure Code");
        ItemJnlLine."Invoiced Quantity" := ABS(QtyToPost);

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
        end else begin
            PostedServiceRequisition."Delivery Status" := PostedServiceRequisition."Delivery Status"::Completed;
        end;
        ;

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

    local procedure CreateWhseDelivery(var SRequisition: Record AfkDocRequisition)
    var
        SRLine: Record AfkDocRequisitionLine;
        WhseDelivery: Record AfkWhseDelivery;
        WhseDeliveryLine: Record AfkWhseDeliveryLine;
    begin

        AddOnSetup.Get();
        AddOnSetup.TestField("Whse Delivery Nos.");

        WhseDelivery.INIT;
        WhseDelivery.TransferFields(SRequisition);
        WhseDelivery."No." := NoSeriesMgt.GetNextNo(AddOnSetup."Whse Delivery Nos.", Today, true);
        WhseDelivery."External Doc No" := SRequisition."No.";
        WhseDelivery.COPYLINKS(SRequisition);
        WhseDelivery.INSERT;

        SRequisition."Delivery Status" := SRequisition."Delivery Status"::Partially;
        SRequisition.Modify();


        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                WhseDeliveryLine.TransferFields(SRLine);
                WhseDeliveryLine."Document No." := WhseDelivery."No.";
                WhseDeliveryLine.Quantity := SRLine."Whse Quantity To Deliver";
                WhseDeliveryLine.Amount := SRLine."Whse Quantity To Deliver" * SRLine."Unit Cost";
                if (WhseDeliveryLine.Quantity <> 0) then begin
                    WhseDeliveryLine.INSERT;
                    PostItemDeliveryEntries(SRequisition, SRLine, SRLine."Whse Quantity To Deliver", WhseDelivery."No.");
                    SRLine."Whse Delivered Quantity" := SRLine."Whse Delivered Quantity" + SRLine."Whse Quantity To Deliver";
                    SRLine."Whse Quantity To Deliver" := 0;
                    SRLine.Modify();
                end;
            UNTIL SRLine.NEXT = 0;

    end;

    local procedure CheckCompletelyDelivered(SRequisition: Record AfkDocRequisition;
     var CompletelyDelivered: Boolean)
    var
        SRLine: Record AfkDocRequisitionLine;
    begin
        CompletelyDelivered := true;
        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                if (SRLine."Whse Delivered Quantity" <> SRLine.Quantity) then
                    CompletelyDelivered := false;
            UNTIL SRLine.NEXT = 0;
    end;

    local procedure QtyToPostExists(SRequisition: Record AfkDocRequisition): Boolean
    var
        SRLine: Record AfkDocRequisitionLine;
    begin

        SRLine.RESET;
        SRLine.SETRANGE(SRLine."Document Type", SRLine."Document Type"::ItemReq);
        SRLine.SETRANGE("Document No.", SRequisition."No.");
        IF SRLine.FINDSET THEN
            REPEAT
                if (SRLine."Whse Quantity To Deliver" <> 0) then
                    exit(true);
            UNTIL SRLine.NEXT = 0;
    end;

    procedure CancelItemRequisition(var PurchH: Record AfkDocRequisition)
    var

    begin

        if not CONFIRM(STRSUBSTNO(Text033, PurchH."No.")) then exit;
        PurchH.PerformManualReOpen();
        DeleteAndArchiveItemRequisition(PurchH, true);
        //PurchH.DELETE(true);

    end;


    var
        AddOnSetup: Record AfkSetup;
        BudgetControl: Codeunit AfkBudgetControl;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text033: Label 'Would you like to close this Item requisition: %1?';
        Text034: Label 'Would you like to post this Item requisition: %1?';
        Text035: Label 'The quantity to be delivered in line %1 is cannot be greater than %2';
        Text036: Label 'There is nothing to post';
}
