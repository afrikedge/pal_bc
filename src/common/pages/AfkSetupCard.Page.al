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

                field("Whse Delivery Nos."; rec."Whse Delivery Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Budget Code"; rec."Default Budget Code")
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Night starting time';
                }
                field("BudgetControlMode"; rec.BudgetControlMode)
                {
                    ApplicationArea = Basic, Suite;
                    //ToolTip = 'Night starting time';
                }
                // field("Budget Period"; rec."Budget Period")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("PR Max Value"; rec."PR Max Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("OrderLetter Max Value"; rec."OrderLetter Max Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BudgetGLAccount"; Rec.BudgetGLAccount)
                {
                    ApplicationArea = Suite;
                }
                field("BudgetedGLAccount"; Rec."Budgeted G/L Account Filter")
                {
                    ApplicationArea = Suite;
                }
                field("XAF Currency Code"; Rec."XAF Currency Code")
                {
                    ApplicationArea = Suite;
                }
                field("SecurityOnBankAccount"; Rec.SecurityOnBankAccount)
                {
                    ApplicationArea = Suite;
                }
                field("SecurityOnVendorPayment"; Rec.SecurityOnVendorPayment)
                {
                    ApplicationArea = Suite;
                }
                field("VendorDeductionMgt"; Rec.VendorDeductionMgt)
                {
                    ApplicationArea = Suite;
                }
                field("TransferNoSuffix"; Rec.TransferNoSuffix)
                {
                    ToolTip = '/BCF/SAF/DD/PAL';
                    ApplicationArea = Suite;
                }
                field("Afk_Elect_Network_Percent"; Rec.Afk_Elect_Network_Percent)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Phone_Network_Percent"; Rec.Afk_Phone_Network_Percent)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Rail_Access_Percent"; Rec.Afk_Rail_Access_Percent)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Road_Access_Percent"; Rec.Afk_Road_Access_Percent)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Strip_On_Quay_Percent"; Rec.Afk_Strip_On_Quay_Percent)
                {
                    ApplicationArea = Suite;
                }
                field("Afk_Water_Network_Percent"; Rec.Afk_Water_Network_Percent)
                {
                    ApplicationArea = Suite;
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

