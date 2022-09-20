table 50005 "AfkPurchaseRequisition"
{
    Caption = 'Purchase Requisition';
    //DrillDownPageID = "Payment Slip List";
    //LookupPageID = "Payment Slip List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AfkSetup.Get();
                    NoSeriesMgt.TestManual(AfkSetup."Purchase Req Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            // CreateDimFromDefaultDim(Rec.FieldNo("Location Code"));
        }
        field(3; "Budget Code"; Code[10])
        {
            Caption = 'Budget Code';
            TableRelation = "G/L Budget Name";
            // CreateDimFromDefaultDim(Rec.FieldNo("Location Code"));
        }

        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Validate("Shortcut Dimension 1 Code");
            end;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Modify;
            end;
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(2, "Shortcut Dimension 2 Code");
                Validate("Shortcut Dimension 2 Code");
            end;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                Modify;
            end;
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(13; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(14; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(15; "External Doc No"; Code[30])
        {
            Caption = 'External Doc. Number';
        }
        field(16; "Reason for rejection"; Text[100])
        {
            Caption = 'Reason for rejection';
        }
        field(17; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            OptionMembers = Item,Service,Intellectual;
            OptionCaption = 'Material/Item,Service,Intellectual service';
        }
        field(18; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionMembers = FA,Item,NonItem,Others;
            OptionCaption = 'Fixed Asset,Item,Non Item,Others';
        }
        field(19; "Processing Status"; Option)
        {
            Caption = 'Processing Status';
            OptionMembers = " ","Partially processed","Totally processed";
            OptionCaption = ' ,Partially processed,Totally processed';
            Editable = false;
        }
        field(30; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Released,"Pending Approval";
            OptionCaption = 'Open,Released,Pending Approval';
            Editable = false;
        }
        field(31; "PR Type"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
        }
        field(32; "PO Type"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        // key(Key2; "Posting Date")
        // {
        // }
    }

    fieldgroups
    {
        // fieldgroup(DropDown; "No.")
        // {
        // }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            AfkSetup.Get();
            AfkSetup.TestField("Purchase Req Nos.");
            NoSeriesMgt.InitSeries(AfkSetup."Purchase Req Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        InitHeader;
    end;

    trigger OnDelete()
    var
        RegLine: Record AfkPurchaseRequisitionLine;
        PurchH: Record "Purchase Header";
        BudgetLineP: Record AfkPurchaseRequisitionBudget;
    begin
        //Supprimer les lignes
        IF NOT CONFIRM(Text001) THEN EXIT;

        RegLine.RESET;
        RegLine.SETRANGE("Document No.", "No.");
        RegLine.DELETEALL(TRUE);

        PurchH.RESET;
        PurchH.SETRANGE("Document Type", PurchH."Document Type"::Quote);
        PurchH.SETRANGE(Afk_RequisitionCode, "No.");
        PurchH.DELETEALL(TRUE);

        BudgetLineP.RESET;
        BudgetLineP.SETRANGE("Document Type", BudgetLineP."Document Type"::Requisition);
        BudgetLineP.SETRANGE("Document No.", "No.");
        BudgetLineP.DELETEALL;

    end;



    var

        PRHeader: Record AfkPurchaseRequisition;
        AfkSetup: Record AfkSetup;
        SourceCodeSetup: Record "Source Code Setup";
        DimManagement: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

        // Text006: Label 'The currency code for the document is the LCY Code.\\Please select a bank for which the currency code is the LCY Code.';
        // Text007: Label 'The currency code for the document is %1.\\Please select a bank for which the currency code is %1 or the LCY Code.';
        // Text008: Label 'Your bank''s currency code is %1.\\You must change the bank account code before modifying the currency code.';
        Text009: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text001: Label 'All offers associated with this request will be deleted! \\Do you want to continue ?';



    procedure LookupShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimManagement.LookupDimValueCode(FieldNo, ShortcutDimCode);
        DimManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
        if xRec."Dimension Set ID" <> "Dimension Set ID" then
            if PRLinesExist() then
                UpdateAllLineDim("Dimension Set ID", xRec."Dimension Set ID");
    end;


    procedure AssistEdit(OldReglHeader: Record AfkPurchaseRequisition): Boolean
    begin

        PRHeader := Rec;
        AfkSetup.Get();
        AfkSetup.TestField("Purchase Req Nos.");
        if NoSeriesMgt.SelectSeries(AfkSetup."Purchase Req Nos.", OldReglHeader."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            Rec := PRHeader;
            exit(true);
        end;

    end;




    procedure InitHeader()
    begin
        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;
    end;





    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        SourceCodeSetup.Get();


        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimManagement.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);



        if (OldDimSetID <> "Dimension Set ID") and PRLinesExist then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        // DimMgt.AddDimSource(DefaultDimSource, Database::Customer, Rec."Bill-to Customer No.", FieldNo = Rec.FieldNo("Bill-to Customer No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Salesperson/Purchaser", Rec."Salesperson Code", FieldNo = Rec.FieldNo("Salesperson Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Campaign, Rec."Campaign No.", FieldNo = Rec.FieldNo("Campaign No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Customer Templ.", Rec."Bill-to Customer Templ. Code", FieldNo = Rec.FieldNo("Bill-to Customer Templ. Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));

    end;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimManagement.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', 'Payment: ', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if PRLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure PRLinesExist(): Boolean
    var
        PrLine: Record AfkPurchaseRequisitionLine;
    begin
        PrLine.Reset();
        PrLine.SetRange("Document No.", "No.");
        exit(PrLine.FindFirst);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        PaymentLine: Record "Payment Line";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(Text009) then
            exit;

        PaymentLine.Reset();
        PaymentLine.SetRange("No.", "No.");
        PaymentLine.LockTable();
        if PaymentLine.Find('-') then
            repeat
                NewDimSetID := DimManagement.GetDeltaDimSetID(PaymentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PaymentLine."Dimension Set ID" <> NewDimSetID then begin
                    PaymentLine."Dimension Set ID" := NewDimSetID;
                    PaymentLine.Modify();
                end;
            until PaymentLine.Next() = 0;
    end;
}

