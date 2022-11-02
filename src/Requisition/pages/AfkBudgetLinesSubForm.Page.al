page 50009 AfkBudgetLinesSubForm
{
    Caption = 'Budget Lines';
    PageType = ListPart;
    SourceTable = AfkDocRequisitionBudget;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dimension Code 1"; Rec."Dimension Code 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension Code 2"; Rec."Dimension Code 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly Budgeted Amt"; Rec."Yearly Budgeted Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly PreCommitment"; Rec."Yearly PreCommitment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly Commitment"; Rec."Yearly Commitment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly Realized Amt"; Rec."Yearly Realized Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly Available Amt"; Rec."Yearly Available Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Amount"; Rec."Document Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }


}
