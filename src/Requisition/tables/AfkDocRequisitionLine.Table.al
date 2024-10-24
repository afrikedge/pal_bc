table 50006 AfkDocRequisitionLine
{
    Caption = 'Purchase Requisition Line';
    DataClassification = CustomerContent;
    //DrillDownPageID = "Purchase Lines";
    //LookupPageID = "Purchase Lines";
    fields
    {

        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(51; "Document Type"; Enum AfkRequisitionDocType)
        {
            Caption = 'Document Type';
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        field(5; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            Editable = false;
            trigger OnValidate()
            begin
                IF Type <> xRec.Type THEN
                    "No." := '';
            end;
        }
        field(6; "No."; Code[20])
        {
            //CaptionClass = GetCaptionClass(FieldNo("No."));
            Caption = 'No.';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                    "Account Type" = CONST(Posting),
                                                                    Blocked = CONST(false))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Blocked = CONST(false), "Purchasing Blocked" = CONST(false))
            else
            if (Type = const(Resource)) Resource;

            //ValidateTableRelation = false;
            trigger OnValidate()
            var

            begin
                GLSetup.GET;

                CASE Type OF
                    Type::Item:
                        BEGIN
                            Item.GET("No.");
                            Item.TESTFIELD(Blocked, FALSE);
                            IF Item.Type = Item.Type::Inventory THEN
                                Item.TESTFIELD("Inventory Posting Group");
                            Item.TESTFIELD("Gen. Prod. Posting Group");

                            CreateDimFromDefaultDim(Rec.FieldNo("No."));

                            // CreateDim(
                            //   DATABASE::Item, "No.",
                            //   DATABASE::Job, '',
                            //   DATABASE::"Responsibility Center", '');


                            Description := Item.Description;
                            "Item Description" := Item.Description;
                            "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                            VALIDATE("VAT Prod. Posting Group", Item."VAT Prod. Posting Group");
                            Item.TESTFIELD("Base Unit of Measure");
                            VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");

                            "Last Direct Cost" := Item."Last Direct Cost";
                            VALIDATE("Unit Cost", Item."Unit Cost");
                            //Item.TESTFIELD("Poste Budgétaire");
                            //IF Item."Code Nature"<>'' THEN
                            //   VALIDATE("Nature code",Item."Code Nature");
                            GetPurchHeader();
                            Validate("Shortcut Dimension 1 Code", PRHeader."Shortcut Dimension 1 Code");


                        END;
                    Type::"G/L Account":
                        BEGIN
                            GLAcc.GET("No.");
                            GLAcc.TESTFIELD(GLAcc.Blocked, FALSE);
                            GLAcc.TESTFIELD("Direct Posting", TRUE);

                            //Serv.GET("No.");
                            GLAcc.TESTFIELD("Gen. Prod. Posting Group");
                            IF Description = '' THEN
                                Description := GLAcc.Name;
                            "Item Description" := GLAcc.Name;

                            CreateDimFromDefaultDim(Rec.FieldNo("No."));

                            // CreateDim(
                            //   DATABASE::"G/L Account", "No.",
                            //   DATABASE::Job, '',
                            //   DATABASE::"Responsibility Center", '');

                            "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                            VALIDATE("VAT Prod. Posting Group", GLAcc."VAT Prod. Posting Group");
                            "Qty. per Unit of Measure" := 1;
                            //Serv.TESTFIELD("Poste Budgétaire");
                            //IF GLAcc."Nature Code"<>'' THEN
                            //   VALIDATE("Nature Code",GLAcc."Code Nature");
                        END;

                    Type::"Charge (Item)":
                        BEGIN
                            ItemCharge.GET("No.");
                            ItemCharge.TESTFIELD("Gen. Prod. Posting Group");
                            Description := ItemCharge.Description;
                            "Item Description" := ItemCharge.Description;
                            CreateDimFromDefaultDim(Rec.FieldNo("No."));
                            // CreateDim(
                            //   DATABASE::"Item Charge", "No.",
                            //   DATABASE::Job, '',
                            //   DATABASE::"Responsibility Center", '');

                            "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
                            VALIDATE("VAT Prod. Posting Group", ItemCharge."VAT Prod. Posting Group");
                            "Qty. per Unit of Measure" := 1;
                            //"Prix Unitaire" := ItemCharge."Prix unitaire";

                            //ItemCharge.TESTFIELD("Poste Budgétaire");
                            //IF ItemCharge."Poste Budgétaire"<>'' THEN
                            //   VALIDATE("Code Section 3",ItemCharge."Poste Budgétaire");
                        END;


                    Type::"Fixed Asset":
                        BEGIN
                            FA.GET("No.");
                            FA.TESTFIELD(Inactive, FALSE);
                            FA.TESTFIELD(Blocked, FALSE);
                            GetFAPostingGroup;
                            CreateDimFromDefaultDim(Rec.FieldNo("No."));
                            // CreateDim(
                            //   DATABASE::"Fixed Asset", "No.",
                            //   DATABASE::Job, '',
                            //   DATABASE::"Responsibility Center", '');

                            Description := FA.Description;
                            "Item Description" := FA.Description;
                            "Qty. per Unit of Measure" := 1;
                            //      "Gen. Prod. Posting Group" := ;
                            //      "VAT Prod. Posting Group" := Serv."VAT Prod. Posting Group";
                            //IF FA."Code Nature"<>'' THEN
                            //   VALIDATE("Code Nature",FA."Code Nature");

                        END;
                END;


                //GetPurchHeader();
                //VALIDATE("Gen. Bus. Posting Group", PRHeader."Gen. Bus. Posting Group");
                //VALIDATE("VAT Bus. Posting Group", ServRequest.v);



                //"Purchase Account" := BudgetMgt.GetPurchAccFromReq(Rec, PRHeader);

            end;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item),
                                "No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            if (Type = const(Resource), "No." = filter(<> '')) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            begin
                IF Type <> Rec.Type::" " THEN BEGIN
                    GetItem;
                    "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, Rec."Unit of Measure Code");
                    VALIDATE(Quantity);
                END;
            end;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                IF Quantity <> xRec.Quantity THEN BEGIN
                    GetPurchHeader;
                    IF PRHeader.Status = PRHeader.Status::Released THEN
                        ERROR(Text001);
                END;


                CalcAmounts();

                IF Type = Type::Item THEN
                    "Quantity (Base)" := CalcBaseQty(Quantity)
                ELSE
                    "Quantity (Base)" := (Quantity);

                "Remaining Quantity (Base)" := "Quantity (Base)" - "Ordered Quantity (Base)";
            end;
        }
        field(9; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
            trigger OnValidate()
            begin
                CalcAmounts();
            end;
        }
        field(11; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(12; Amount; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            trigger OnValidate()
            begin
                "Amount (LCY)" := Amount;
                GetPurchHeader();
                AfkBudgetControlMgt.CreatePurchaseBudgetLines_ItemReq(PRHeader, true);
            end;
        }
        field(72; "VAT Amount"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            Editable = false;

        }
        field(13; "Amount Including VAT"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;

        }
        field(53; "Amount Including VAT (LCY)"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;

        }
        field(54; "Amount (LCY)"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;
        }

        field(14; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            trigger OnValidate()
            begin
                CalcAmounts();
            end;
        }
        field(16; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            trigger OnValidate()
            var
                VATPostingSetup: Record "VAT Posting Setup";
            begin
                GetPurchHeader();
                IF VATPostingSetup.Get(PRHeader."VAT Bus. Posting Group", "VAT Prod. Posting Group") then begin
                    VALIDATE("VAT %", VATPostingSetup."VAT %");
                end;
            end;
        }
        field(17; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(19; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(20; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(23; "Ordered Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(24; "Remaining Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(25; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";

        }
        field(26; "Serial No."; Code[30])
        {
            Caption = 'Serial No.';
        }
        field(27; "Item Reference"; Code[30])
        {
            Caption = 'Item Reference';
        }

        field(28; "Purchase Account"; Code[20])
        {
            Caption = 'Purchase Account';
            Editable = false;
        }
        field(29; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            Editable = false;
        }
        field(30; "Last Direct Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Last Direct Cost';
            MinValue = 0;
        }
        field(31; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }

        field(482; "Whse Quantity To Deliver"; Decimal)
        {
            Caption = 'Quantity To Deliver';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(483; "Whse Delivered Quantity"; Decimal)
        {
            Caption = 'Delivered Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Purchase Account", "Shortcut Dimension 1 Code")
        {
        }
    }
    trigger OnInsert()
    begin
        TestStatusOpen();
        GetPurchHeader();
        "Location Code" := PRHeader."Location Code";

    end;

    var
        PRHeader: Record "AfkDocRequisition";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        FADeprBook: Record "FA Depreciation Book";
        FAPostingGr: Record "FA Posting Group";
        FASetup: Record "FA Setup";
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        LocalGLAcc: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        ItemCharge: Record "Item Charge";
        AfkBudgetControlMgt: Codeunit AfkBudgetControl;
        BudgetMgt: Codeunit AfkBudgetControl;
        DimMgt: Codeunit DimensionManagement;
        //ServRequest: Record AfkPurchaseRequisition;
        UOMMgt: Codeunit "Unit of Measure Management";
        Text001: Label 'The request can no longer be modified because it has already been validated';

    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
        IsHandled: Boolean;
    begin

        SourceCodeSetup.Get();

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        GetPurchHeader();
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Purchases,
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", PRHeader."Dimension Set ID", DATABASE::Vendor);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    procedure GetItem()
    begin
        IF Item."No." <> Rec."No." THEN
            Item.GET("No.");
    end;

    procedure GetPurchHeader(): Record "AfkDocRequisition"
    begin
        GetPurchHeader(PRHeader, Currency);
        exit(PRHeader);
    end;

    procedure GetPurchHeader(var OutPurchHeader: Record "AfkDocRequisition"; var OutCurrency: Record Currency)
    begin
        TestField("Document No.");
        if (("Document No." <> PRHeader."No.") or ("Document Type" <> PRHeader."Document Type")) then begin
            PRHeader.Get("Document Type", "Document No.");
            if PRHeader."Currency Code" = '' then
                Currency.InitRoundingPrecision
            else begin
                //PurchHeader.TestField("Currency Factor");
                Currency.Get(PRHeader."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
        end;
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', 0, "Document No.", "Line No."));
        //VerifyItemLineDim();
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";


    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;



    procedure TestStatusOpen()
    begin
        GetPurchHeader;
        IF Type <> Type::" " THEN
            IF PRHeader.Status = PRHeader.Status::Released THEN
                ERROR(Text001);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //VerifyItemLineDim;

    end;

    local procedure CalcAmounts()
    var
        factor: Decimal;
    begin
        "Amount" := Round(Quantity * "Unit Cost", Currency."Amount Rounding Precision");
        "VAT Amount" := Round("VAT %" * Amount / 100, Currency."Amount Rounding Precision");
        "Amount Including VAT" := "Amount" + "VAT Amount";
        "Amount (LCY)" := "Amount";

        GetPurchHeader();
        PRHeader.TestStatusOpen();
        factor := CurrExchRate.ExchangeRate(PRHeader."Document Date", PRHeader."Currency Code");
        IF PRHeader."Currency Code" = '' THEN
            "Amount Including VAT (LCY)" := "Amount Including VAT"
        ELSE
            "Amount Including VAT (LCY)" := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  PRHeader."Document Date", PRHeader."Currency Code",
                  "Amount Including VAT (LCY)", factor));

        BudgetMgt.CreatePurchaseBudgetLines_ItemReq(PRHeader, true);
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure GetFAPostingGroup()
    var
        myInt: Integer;
    begin
        IF (Type <> Type::"G/L Account") OR ("No." = '') THEN
            EXIT;

        IF "Depreciation Book Code" = '' THEN BEGIN
            FASetup.GET;
            "Depreciation Book Code" := FASetup."Default Depr. Book";
            MESSAGE('2 %1', "Depreciation Book Code");
            IF NOT FADeprBook.GET("No.", "Depreciation Book Code") THEN
                "Depreciation Book Code" := '';
            IF "Depreciation Book Code" = '' THEN
                EXIT;
        END;

        //MESSAGE('3 %1',"Depreciation Book Code");
        FADeprBook.GET("No.", "Depreciation Book Code");
        FADeprBook.TESTFIELD("FA Posting Group");
        FAPostingGr.GET(FADeprBook."FA Posting Group");

        FAPostingGr.TESTFIELD("Acquisition Cost Account");
        LocalGLAcc.GET(FAPostingGr."Acquisition Cost Account");

        LocalGLAcc.CheckGLAcc;
        LocalGLAcc.TESTFIELD("Gen. Prod. Posting Group");

        "Posting Group" := FADeprBook."FA Posting Group";
        "Gen. Prod. Posting Group" := LocalGLAcc."Gen. Prod. Posting Group";
        VALIDATE("VAT Prod. Posting Group", LocalGLAcc."VAT Prod. Posting Group");
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        DimMgt.AddDimSource(DefaultDimSource, DimMgt.PurchLineTypeToTableID(Rec.Type), Rec."No.", FieldNo = Rec.FieldNo("No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Job, Rec."Job No.", FieldNo = Rec.FieldNo("Job No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Work Center", Rec."Work Center No.", FieldNo = Rec.FieldNo("Work Center No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));

        // OnAfterInitDefaultDimensionSources(Rec, DefaultDimSource);
    end;



}