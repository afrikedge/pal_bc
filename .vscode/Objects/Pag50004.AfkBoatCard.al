page 50004 AfkBoatCard
{
    Caption = 'Vessel';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Afk_Boat;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(OMI_Number; rec.OMI_Number)
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    ToolTip = 'Specifies the vessel registration.';

                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ship''s name';
                }
                field("BoatType"; rec.BoatType)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the ship.';
                }
                field(Length; rec.Length)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    //Editable = false;
                    //Importance = Promoted;
                    ToolTip = 'Specifies the vessel length in meters.';
                }
                field(Width; rec.Width)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    //Editable = false;
                    //Importance = Promoted;
                    ToolTip = 'Specifies the vessel width in meters';
                }
                field("Boat Draught"; rec."Boat Draught")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the height in meters of the submerged part of the boat which varies according to the load transported.';
                }
                field("Calculated Boat Draught"; rec."Calculated Boat Draught")
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the height in meters of the submerged part of the boat which varies according to the load transported.';
                }
                field(Volume; rec.Volume)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    Editable = false;
                    ToolTip = 'Specifies the vessel volume in m3.';
                }
                field("Weight"; rec.Weight)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the weight of the ship.';
                }
                field("TJB"; rec.TJB)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the full interior capacity of the vessel in tons.';
                }
                field(TJN; rec.TJN)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the interior capacity uses of vessel in barrel.';
                }
                field("Pavillon"; rec.Pavillon)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country of registry of the ship.';
                }
                field("Agent"; rec.Agent)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the consignee of the vessel.';
                }
                field("NavigationType"; rec.NavigationType)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the navigation type of the ship.';
                }

                field("CallSign"; rec.CallSign)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the navigation type of the ship.';
                }
                field("ShipOwner"; rec.ShipOwner)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the navigation type of the ship.';
                }
                field("MasterName"; rec.MasterName)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the navigation type of the ship.';
                }
                field("TypeOfOperation"; rec.TypeOfOperation)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the navigation type of the ship.';
                }
                field("Drivable"; rec.Drivable)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Specifies the navigation type of the ship.';
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



}

