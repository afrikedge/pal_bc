pageextension 50003 AfkItemList extends "Item List"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Afk_Quantity1"; Rec.Afk_Quantity1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_1"; Rec.Afk_Unit_of_Measure_Code_1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Quantity2"; Rec.Afk_Quantity2)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_2"; Rec.Afk_Unit_of_Measure_Code_2)
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}