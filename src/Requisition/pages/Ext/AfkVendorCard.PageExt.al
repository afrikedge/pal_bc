pageextension 50023 AfkVendorCard extends "Vendor Card"
{
    layout
    {
        addafter("Vendor Posting Group")
        {
            field("Afk_IR_Pourcent"; Rec.Afk_IR_Pourcent)
            {
                ApplicationArea = Basic;
            }

            field("Afk_TSR_Pourcent"; Rec.Afk_TSR_Pourcent)
            {
                ApplicationArea = Basic;
            }
        }
    }
}
