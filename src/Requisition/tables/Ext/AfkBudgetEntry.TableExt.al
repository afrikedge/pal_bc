tableextension 50009 AfkBudgetEntry extends "G/L Budget Entry"
{
    fields
    {
        field(50000; "Afk_Operation_Type"; Enum AfkBudgetOperationType)
        {
            Caption = 'Operation Type';
            DataClassification = CustomerContent;
        }
    }
}
