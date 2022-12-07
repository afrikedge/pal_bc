pageextension 50000 AfkItemCard extends "Item Card"
{
    layout
    {
        addlast("Prices & Sales")
        {
            field("Afk_Quantity1"; Rec.Afk_Quantity1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Quantity2"; Rec.Afk_Quantity2)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_1"; Rec.Afk_Unit_of_Measure_Code_1)
            {
                ApplicationArea = Suite;
            }
            field("Afk_Unit_of_Measure_Code_2"; Rec.Afk_Unit_of_Measure_Code_2)
            {
                ApplicationArea = Suite;
            }
        }
        addafter("Description")
        {
            field("Afk_Description_2"; Rec."Description 2")
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