page 50001 "AfkCalcParameters"
{
    AdditionalSearchTerms = 'calc params';
    ApplicationArea = Basic, Suite;
    Caption = 'Calculator parameters';
    PageType = List;
    SourceTable = Afk_Calc_Parameter;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the boat type';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the boat type.';
                }
                field(DataType1; Rec.DataType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this parameter is calculated or simply a fixed value.';
                }
                field(Value1; Rec.Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fixed value of this parameter';
                }
                field(System1; Rec.System)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a description of the boat type.';
                    //Editable=false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                //Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                //Visible = false;
            }
        }
    }

}