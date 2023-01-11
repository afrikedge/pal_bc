page 50017 AfkBankAcountUsers
{
    ApplicationArea = All;
    Caption = 'Bank Account Users';
    PageType = List;
    SourceTable = AfkSecurityItem;
    SourceTableView = WHERE("Account Type" = FILTER(BankAccount));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Account Code"; Rec."Account Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account';
                }
            }
        }
    }
}
