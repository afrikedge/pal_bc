pageextension 50032 AfkApplyCustEntries extends "Apply Customer Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Afk_ExternalDocument"; Rec."External Document No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
