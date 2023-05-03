tableextension 50023 AfkPurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; Afk_RequisitionCode; Code[20])
        {
            Caption = 'Requisition Code';
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_PRDescription"; Code[250])
        {
            Caption = 'PR Description';
            DataClassification = CustomerContent;
        }
        field(50002; "Afk_PRType"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
            DataClassification = CustomerContent;
        }
        field(50003; "Afk_POType"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
            DataClassification = CustomerContent;
        }
        field(50004; "Afk_PurchaseType"; Option)
        {
            Caption = 'Purchase Type';
            OptionMembers = Item,Service,Intellectual;
            OptionCaption = 'Material/Item,Service,Intellectual service';
            DataClassification = CustomerContent;
        }
        field(50005; "Afk_BudgetCode"; Code[10])
        {
            Caption = 'Budget Code';
            TableRelation = "G/L Budget Name";
            DataClassification = CustomerContent;
        }
        field(50006; "Afk_ProcessingStatus"; Enum AfkProcessingStatus)
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
        }
        field(50007; "Afk_VendorNotified"; Boolean)
        {
            Caption = 'Vendor Notified';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (not xRec.Afk_VendorNotified) then
                    Afk_NotificationDate := Today();
            end;
        }
        field(50008; "Afk_NotificationDate"; Date)
        {
            Caption = 'Notification Date';
            DataClassification = CustomerContent;

        }
        field(50009; "Afk_CommitmentType"; Enum AfkCommitmentType)
        {
            Caption = 'Commitment Type';
            DataClassification = CustomerContent;
        }
        field(50011; "Afk_Validity"; Integer)
        {
            Caption = 'Validity (Days)';
            DataClassification = CustomerContent;
        }
        field(50012; "Afk_ValidityEndingDate"; Date)
        {
            Caption = 'Validity Ending Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50013; "Afk_ReleaseDate"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50014; "Afk_OrderCreationDate"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Afk_OrderNoCreated"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Afk_Object"; Code[250])
        {
            Caption = 'Purpose of expense';
            DataClassification = CustomerContent;
        }
        field(50019; "Afk_IssuerCode"; Code[50])
        {
            Caption = 'Issuer Code';
            DataClassification = CustomerContent;
            Editable = false;
            //TableRelation = Afk_Service;
        }
        field(50020; "Afk_ProformaDate"; Date)
        {
            Caption = 'Proforma Invoice Date';
            DataClassification = CustomerContent;
        }
    }
}

