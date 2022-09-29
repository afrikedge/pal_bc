page 50003 "AfkBoatList"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Vessel List';
    CardPageID = AfkBoatCard;
    Editable = false;
    PageType = List;
    SourceTable = Afk_Boat;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field(OMI_Number; Rec.OMI_Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vessel registration.';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ship''s name';
                }
                field(Length; rec.Length)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vessel length in meters.';
                }
                field(Width; rec.Width)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vessel width in meters';
                }
                field("Boat Draught"; rec."Boat Draught")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the height in meters of the submerged part of the boat which varies according to the load transported.';
                }
                field("Volume"; rec.Volume)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vessel volume in m3.';
                }
                field("TJB"; rec.TJB)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the full interior capacity of the vessel in tons.';
                }
                field("TJN"; rec.TJN)
                {
                    ApplicationArea = Basic, Suite;
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
                field("BoatType"; rec.BoatType)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the ship.';
                }
                field("NavigationType"; rec.NavigationType)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the navigation type of the ship.';
                }
                field("Weight"; rec.Weight)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the weight of the ship.';
                }

            }
        }
    }

    actions
    {
        area(creation)
        {
            /* action("Create Payment Slip")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Payment Slip';
                Image = NewDocument;
                RunObject = Codeunit "Payment Management";
                ToolTip = 'Manage information about customer and vendor payments.';
            } */
        }
    }
}

