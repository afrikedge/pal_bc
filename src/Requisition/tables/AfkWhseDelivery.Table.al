table 50010 AfkWhseDelivery
{
    Caption = 'Delivery Form';
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
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';

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
        field(31; "PR Type"; Option)
        {
            Caption = 'Purchase Requisition Type';
            OptionMembers = " ";
            OptionCaption = ' ';
        }
        field(32; "PO Type"; Option)
        {
            Caption = 'Purchase Order Type';
            OptionMembers = " ";
            OptionCaption = ' ';
        }

        field(58; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum(AfkWhseDeliveryLine."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum(AfkWhseDeliveryLine.Amount WHERE("Document No." = FIELD("No.")));
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


        field(60; "Delivery Status"; Enum AfkPRDeliveryStatus)
        {
            Caption = 'Delivery Status';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }

        field(50000; "Item Requisition No"; Code[20])
        {
            Caption = 'No.';
            Editable = false;
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
}
