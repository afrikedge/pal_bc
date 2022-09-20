tableextension 50005 AfkPurchaseHeader extends "Purchase Header"
{
    fields
    {
        field(50000; Afk_RequisitionCode; Code[20])
        {
            Caption = 'Requisition Code';
        }
        field(50001; "PR Description"; Text[250])
        {
            Caption = 'PR Description';
        }
        field(50002; "PR Type"; Enum AfkPurchReqType)
        {
            Caption = 'Purchase Requisition Type';
        }
        field(50003; "PO Type"; Enum AfkPurchOrderType)
        {
            Caption = 'Purchase Order Type';
        }
        field(50004; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            OptionMembers = Item,Service,Intellectual;
            OptionCaption = 'Material/Item,Service,Intellectual service';
        }
        field(50005; "Budget Code"; Code[10])
        {
            Caption = 'Budget Code';
            TableRelation = "G/L Budget Name";
        }
        field(50006; "Afk_ProcessingStatus"; Option)
        {
            Caption = 'Purchase Type';
            OptionMembers = " ",Closed;
            OptionCaption = ' ,Closed';
        }
    }

}