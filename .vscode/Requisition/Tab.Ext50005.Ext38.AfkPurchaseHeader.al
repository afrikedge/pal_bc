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
        field(50002; "PR Type"; Option)
        {
            Caption = 'Purchase Requisition Type';
            OptionMembers = " ";
            OptionCaption = ' ';
        }
        field(50003; "PO Type"; Option)
        {
            Caption = 'Purchase Order Type';
            OptionMembers = " ";
            OptionCaption = ' ';
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
    }

}