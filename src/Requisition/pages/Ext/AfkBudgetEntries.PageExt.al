pageextension 50013 AfkBudgetEntries extends "G/L Budget Entries"
{
    Editable = false;

    layout
    {
        // modify("G/L Account No.")
        // {
        //     Caption = 'Nature';
        // }
        addlast(Control1)
        {
            field("Afk_Operation_Type"; Rec.Afk_Operation_Type)
            {
                ApplicationArea = Suite;
            }
        }
    }
}
