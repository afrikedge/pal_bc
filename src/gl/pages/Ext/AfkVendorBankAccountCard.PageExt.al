pageextension 50028 AfkVendorBankAccountCard extends "Vendor Bank Account Card"
{
    layout
    {
        addafter(Name)
        {
            field("AfkBeneficiary"; Rec.AfkBeneficiary)
            {
                ApplicationArea = Basic;
            }
        }
        addbefore("RIB Key")
        {
            field(AfkRIBKeyText; Rec."AfkRIBKeyText")
            {
                ApplicationArea = Suite;

                trigger OnValidate()
                begin
                    Evaluate(Rec."RIB Key", Rec.AfkRIBKeyText);
                end;
            }
        }
        modify("RIB Key")
        {
            Visible = false;
        }
    }
}
