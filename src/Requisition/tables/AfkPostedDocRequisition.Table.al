table 50008 "AfkPostedDocRequisition"
{
    Caption = 'Posted Purchase Requisition';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(51; "Document Type"; Enum AfkRequisitionDocType)
        {
            Caption = 'Document Type';
        }
        field(2; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(3; "Budget Code"; Code[10])
        {
            Caption = 'Budget Code';
            TableRelation = "G/L Budget Name";
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
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Validate("Shortcut Dimension 1 Code");
            end;

        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(2, "Shortcut Dimension 2 Code");
                Validate("Shortcut Dimension 2 Code");
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
            OptionCaption = 'Material/Item,Service,Intellectual service';
            OptionMembers = Item,Service,Intellectual;
        }
        field(18; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionCaption = 'Fixed Asset,Item,Non Item,Others';
            OptionMembers = FA,Item,NonItem,Others;
        }
        field(19; "Processing Status"; Option)
        {
            Caption = 'Processing Status';
            Editable = false;
            OptionCaption = ' ,Partially processed,Totally processed';
            OptionMembers = " ","Partially processed","Totally processed";
        }
        field(30; "Status"; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(31; "PR Type"; Option)
        {
            Caption = 'Purchase Requisition Type';
            OptionCaption = ' ';
            OptionMembers = " ";
        }
        field(32; "PO Type"; Option)
        {
            Caption = 'Purchase Order Type';
            OptionCaption = ' ';
            OptionMembers = " ";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(58; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum(AfkPostDocRequisitionLine."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum(AfkPostDocRequisitionLine."Amount Including VAT (LCY)" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        field(50000; "Created Doc Type"; Option)
        {
            Caption = 'Created Doc Type';
            OptionCaption = 'Purchase order,Contract';
            OptionMembers = "Commande","Contrat";
        }
        field(50001; "Created Doc Code"; Code[20])
        {
            Caption = 'Created Doc Code';
        }
        field(50002; "Closed Date"; Date)
        {
            Caption = '"Closed Date"';
        }
        field(50003; "Closed By"; Code[50])
        {
            Caption = 'Closed By';
        }
        field(50006; "Afk_ProcessingStatus"; Enum AfkProcessingStatus)
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
        }
        field(60; "Delivery Status"; Enum AfkPRDeliveryStatus)
        {
            Caption = 'Delivery Status';
            Editable = false;
        }
        field(481; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }



    var

        PRHeader: Record "AfkDocRequisition";
        AfkSetup: Record AfkSetup;
        SourceCodeSetup: Record "Source Code Setup";
        DimManagement: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'All offers associated with this request will be deleted! \\Do you want to continue ?';

        // Text006: Label 'The currency code for the document is the LCY Code.\\Please select a bank for which the currency code is the LCY Code.';
        // Text007: Label 'The currency code for the document is %1.\\Please select a bank for which the currency code is %1 or the LCY Code.';
        // Text008: Label 'Your bank''s currency code is %1.\\You must change the bank account code before modifying the currency code.';
        Text009: Label 'You may have changed a dimension.\\Do you want to update the lines?';



    procedure LookupShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimManagement.LookupDimValueCode(FieldNo, ShortcutDimCode);
        DimManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
    end;

    // procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimManagement.ValidateShortcutDimValues(FieldNo, ShortcutDimCode, "Dimension Set ID");
    //     if xRec."Dimension Set ID" <> "Dimension Set ID" then
    //         if PRLinesExist() then
    //             UpdateAllLineDim("Dimension Set ID", xRec."Dimension Set ID");
    // end;






    procedure InitHeader()
    begin
        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;
    end;





    // procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    // var
    //     SourceCodeSetup: Record "Source Code Setup";
    //     OldDimSetID: Integer;
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;

    //     if IsHandled then
    //         exit;

    //     SourceCodeSetup.Get();


    //     "Shortcut Dimension 1 Code" := '';
    //     "Shortcut Dimension 2 Code" := '';
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimManagement.GetRecDefaultDimID(
    //         Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);



    //     if (OldDimSetID <> "Dimension Set ID") and PRLinesExist then begin
    //         Modify;
    //         UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    //     end;
    // end;

    // procedure CreateDimFromDefaultDim(FieldNo: Integer)
    // var
    //     DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    // begin
    //     InitDefaultDimensionSources(DefaultDimSource, FieldNo);
    //     CreateDim(DefaultDimSource);
    // end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        // DimMgt.AddDimSource(DefaultDimSource, Database::Customer, Rec."Bill-to Customer No.", FieldNo = Rec.FieldNo("Bill-to Customer No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Salesperson/Purchaser", Rec."Salesperson Code", FieldNo = Rec.FieldNo("Salesperson Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Campaign, Rec."Campaign No.", FieldNo = Rec.FieldNo("Campaign No."));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::"Customer Templ.", Rec."Bill-to Customer Templ. Code", FieldNo = Rec.FieldNo("Bill-to Customer Templ. Code"));
        // DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));

    end;


    // procedure ShowDocDim()
    // var
    //     OldDimSetID: Integer;
    // begin
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimManagement.EditDimensionSet(
    //         "Dimension Set ID", StrSubstNo('%1 %2', 'Payment: ', "No."),
    //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    //     if OldDimSetID <> "Dimension Set ID" then begin
    //         Modify;
    //         if PRLinesExist() then
    //             UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    //     end;
    // end;

    // procedure PRLinesExist(): Boolean
    // var
    //     PrLine: Record AfkPurchaseRequisitionLine;
    // begin
    //     PrLine.Reset();
    //     PrLine.SetRange("Document No.", "No.");
    //     exit(PrLine.FindFirst);
    // end;

    // local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    // var
    //     PaymentLine: Record "Payment Line";
    //     NewDimSetID: Integer;
    // begin
    //     // Update all lines with changed dimensions.

    //     if NewParentDimSetID = OldParentDimSetID then
    //         exit;
    //     if not Confirm(Text009) then
    //         exit;

    //     PaymentLine.Reset();
    //     PaymentLine.SetRange("No.", "No.");
    //     PaymentLine.LockTable();
    //     if PaymentLine.Find('-') then
    //         repeat
    //             NewDimSetID := DimManagement.GetDeltaDimSetID(PaymentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
    //             if PaymentLine."Dimension Set ID" <> NewDimSetID then begin
    //                 PaymentLine."Dimension Set ID" := NewDimSetID;
    //                 PaymentLine.Modify();
    //             end;
    //         until PaymentLine.Next() = 0;
    // end;
}

