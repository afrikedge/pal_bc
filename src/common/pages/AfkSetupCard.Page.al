page 50005 AfkSetupCard
{
    Caption = 'AFK Setup';
    AdditionalSearchTerms = 'params';
    PageType = Card;
    //RefreshOnActivate = true;
    SourceTable = AfkSetup;

    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DayStartingTime; rec."Day starting time")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    ToolTip = 'Day starting time.';

                }
                field(NightStartingTime; rec."Night starting time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Night starting time';
                }
                field("Purchase Req Nos."; rec."Purchase Req Nos.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Default Budget Code"; rec."Default Budget Code")
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Night starting time';
                }
                field("Budget Period"; rec."Budget Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PR Max Value"; rec."PR Max Value")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

}

