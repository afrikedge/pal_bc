tableextension 50003 AfkCustomer extends "Customer"
{
    fields
    {
        field(50000; Afk_TradeRegister; Code[50])
        {
            //Registre de commerce
            Caption = 'Trade Register';
            DataClassification = CustomerContent;
        }
        field(50001; "Afk_Tax_Number"; Code[50])
        {
            //Numéro contribuable
            Caption = 'Tax Number';
            DataClassification = CustomerContent;
        }
    }

}