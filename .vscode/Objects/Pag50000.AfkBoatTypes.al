page 50000 "AfkBoatTypes"
{
    AdditionalSearchTerms = 'boat types';
    ApplicationArea = Basic, Suite;
    Caption = 'Boat types';
    PageType = List;
    SourceTable = Afk_Generic_Type;
    SourceTableView = WHERE("RecordType" = FILTER(BoatType));
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
                    ApplicationArea = Basic, Suite, Invoicing;
                    ToolTip = 'Specifies a code for the boat type';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite, Invoicing;
                    ToolTip = 'Specifies a description of the boat type.';
                }
                field(Drivable; Rec.Drivable)
                {
                    ApplicationArea = Basic, Suite, Invoicing;
                    ToolTip = 'Specifies if the boat is drivable.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }





    var

}

