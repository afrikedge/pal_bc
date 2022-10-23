pageextension 50012 AfkBudget extends Budget
{
    layout
    {
        modify(GLAccFilter)
        {
            Caption = 'Nature Filter';
        }
    }

    actions
    {
        addafter("Reverse Lines and Columns")
        {
            action("AfkBudgetTransfer")
            {
                ApplicationArea = Suite;
                Caption = 'Budget line transfer';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //ToolTip = 'Change the display of the matrix by inverting the values in the Show as Lines and Show as Columns fields.';


                trigger OnAction()
                var
                    AfkBudgetLineTransfer: Report AfkBudgetLineTransfer;
                begin
                    AfkBudgetLineTransfer.SetBudgetCode(BudgetName, true);
                    AfkBudgetLineTransfer.RunModal();
                end;
            }
            action("AfkBudgetRevision")
            {
                ApplicationArea = Suite;
                Caption = 'Budget line revision';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //ToolTip = 'Change the display of the matrix by inverting the values in the Show as Lines and Show as Columns fields.';


                trigger OnAction()
                var
                    AfkBudgetLineTransfer: Report AfkBudgetLineTransfer;
                begin
                    AfkBudgetLineTransfer.SetBudgetCode(BudgetName, false);
                    AfkBudgetLineTransfer.RunModal();
                end;
            }
        }
    }
}
