pageextension 50030 AfkItemLookup extends "Item Lookup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("AfkItemCategoryCode"; Rec."Item Category Code")
            {
                ApplicationArea = Suite;
            }
            field("AfkDescription2"; Rec."Description 2")
            {
                ApplicationArea = Suite;
            }
        }

    }
}
