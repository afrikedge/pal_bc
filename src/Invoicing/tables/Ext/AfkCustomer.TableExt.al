tableextension 50003 AfkCustomer extends "Customer"
{
    fields
    {
        field(50000; Afk_TradeRegister; Code[30])
        {
            //Registre de commerce
            Caption = 'Trade Register';
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_Tax_Number"; Code[30])
        {
            //Numéro contribuable
            Caption = 'Tax Number';
            DataClassification = CustomerContent;
        }
    }

}