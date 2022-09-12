table 50006 AfkPurchaseRequisitionLine
{
    Caption = 'Purchase Requisition Line';
    //DrillDownPageID = "Purchase Lines";
    //LookupPageID = "Purchase Lines";
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
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

            ValidateTableRelation = false;
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
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        // field(9; "Unit Price"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Unit Price';
        // }
        field(10; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(11; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        // field(12; Amount; Decimal)
        // {
        //     //AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     Caption = 'Amount';
        //     //Editable = false;
        // }
        // field(13; "Amount Including VAT"; Decimal)
        // {
        //     //AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     Caption = 'Amount Including VAT';
        //     Editable = false;
        // }
        // field(14; "VAT %"; Decimal)
        // {
        //     Caption = 'VAT %';
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        // }
        field(15; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(16; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
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
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
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

            // trigger OnValidate()
            // begin
            //     GetFAPostingGroup();
            // end;
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
        // field(30; "System-Created Entry"; Boolean)
        // {
        //     Caption = 'System-Created Entry';
        //     Editable = false;
        // }

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

    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()

    begin
        TestStatusOpen();
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        PurchHeader: Record "AfkPurchaseRequisition";
        GLSetup: Record "General Ledger Setup";
        Text001: Label 'The request can no longer be modified because it has already been validated';

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //VerifyItemLineDim;

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
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", PurchHeader."Dimension Set ID", DATABASE::Vendor);
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    end;

    procedure GetPurchHeader(): Record AfkPurchaseRequisition
    begin
        TestField("Document No.");
        if ("Document No." <> PurchHeader."No.") then
            PurchHeader.Get("Document No.");
        exit(PurchHeader);
    end;

    procedure TestStatusOpen()
    begin
        GetPurchHeader;
        IF Type <> Type::" " THEN
            IF PurchHeader.Status = PurchHeader.Status::Released THEN
                ERROR(Text001);
    end;
}