pageextension 50024 AfkCompanyInfoCard extends "Company Information"
{
    layout
    {
        modify("Registration No.")
        {
            Caption = 'VAT Registration Number';
        }
        modify("Trade Register")
        {
            Caption = 'Registration Number (RCCM)';
        }
        modify("APE Code")
        {
            Caption = 'NACAM';
        }
        modify("CISD")
        {
            Visible = false;
        }
    }
}
