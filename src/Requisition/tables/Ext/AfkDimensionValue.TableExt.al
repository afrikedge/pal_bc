tableextension 50007 AfkDimensionValue extends "Dimension Value"
{
    fields
    {
        field(50000; "AfkBudgetLevel"; enum AfkBudgetLevel)
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (AfkBudgetLevel <> AfkBudgetLevel::Task) then begin
                    AfkBudgetStructure := '';
                end;
            end;
        }
        field(50001; AfkBudgetTaskType; enum AfkBudgetTask)
        {
            Caption = 'Task Level';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (AfkBudgetLevel <> AfkBudgetLevel::Task) then
                    if (AfkBudgetTaskType <> AfkBudgetTaskType::" ") then
                        Error(ReservedForTaskLineErr);
            end;
        }
        field(50002; "AfkBudgetStructure"; Code[20])
        {
            Caption = 'Structure';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('STRUCTURE'));
            trigger OnValidate()
            begin
                if (AfkBudgetLevel <> AfkBudgetLevel::Task) then
                    if (AfkBudgetStructure <> '') then
                        Error(ReservedForTaskLineErr);
            end;
        }
        field(50003; AfkBudgetStructureLevel; enum AfkStructureLevel)
        {
            Caption = 'Structure Level';
            DataClassification = CustomerContent;
        }


    }
    var
        ReservedForTaskLineErr: Label 'This code is reserved for Task level lines';
}
