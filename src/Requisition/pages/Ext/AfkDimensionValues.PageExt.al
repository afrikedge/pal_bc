pageextension 50011 AfkDimensionValues extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field(AfkBudgetLevel; Rec.AfkBudgetLevel)
            {
                ApplicationArea = All;
                //ToolTip = 'Specifies the value of the Level field.';
            }
            field(AfkBudgetTask; Rec.AfkBudgetTaskType)
            {
                ApplicationArea = All;
                //ToolTip = 'Specifies the value of the Task field.';
            }
            field(AfkBudgetStructureLevel; Rec.AfkBudgetStructureLevel)
            {
                ApplicationArea = All;
                //ToolTip = 'Specifies the value of the Task field.';
            }
            field(AfkBudgetStructure; Rec.AfkBudgetStructure)
            {
                ApplicationArea = All;
                //ToolTip = 'Specifies the value of the Structure field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}
