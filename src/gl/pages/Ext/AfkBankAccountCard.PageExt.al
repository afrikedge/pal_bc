pageextension 50044 AfkBankAccountCard extends "Bank Account Card"
{
    layout
    {
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
