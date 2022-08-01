page 50002 "AfkSalesInvPricing"
{
    AdditionalSearchTerms = 'pricing';
    ApplicationArea = Basic, Suite;
    Caption = 'Port Services Pricing';
    PageType = List;
    SourceTable = Afk_Princing;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Service Name"; Rec."Service Name")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field(Terminal; Rec.Terminal)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field(BoatType; Rec.BoatType)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field(Pavillon; Rec.Pavillon)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Unit of Measure Code 1"; Rec."Unit of Measure Code 1")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Unit of Measure Code 2"; Rec."Unit of Measure Code 2")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                    //Visible = false;
                }
                field("Minimum Quantity 1"; Rec."Minimum Quantity 1")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Minimum Quantity 2"; Rec."Minimum Quantity 2")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                    Visible = false;
                }
                field("Maximum Quantity 1"; Rec."Maximum Quantity 1")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }

                field("Maximum Quantity 2"; Rec."Maximum Quantity 2")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field(QtyCalculation; Rec.QtyCalculation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how final quantity is calculated';
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field(Majoration; Rec.Majoration)
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies a code for the boat type';
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

