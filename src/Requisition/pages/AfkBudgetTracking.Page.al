page 50010 AfkBudgetTracking
{
    Caption = 'Budget Tracking';
    PageType = Worksheet;

    //Editable = false;
    ApplicationArea = Basic, Suite;
    UsageCategory = Tasks;
    PromotedActionCategories = 'Process,Report';
    SaveValues = true;
    SourceTable = "AfkDocRequisitionBudget";
    SourceTableView = WHERE("Document Type" = FILTER(BudgetTracking));

    layout
    {
        area(content)
        {
            field(BudgetCode; BudgetCode)
            {
                Caption = 'Budget Code';
                ApplicationArea = Basic, Suite;
                TableRelation = "G/L Budget Name";

            }
            field(TaskFilter; TaskFilter)
            {
                Caption = 'Task filter';
                ApplicationArea = Basic, Suite;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            }
            field(NatureFilter; NatureFilter)
            {
                Caption = 'Nature filter';
                ApplicationArea = Basic, Suite;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            }
            field(StructureFilter; StructureFilter)
            {
                Caption = 'Structure filter';
                ApplicationArea = Basic, Suite;
                TableRelation = "Dimension Value".Code where("Dimension Code" = const('STRUCTURE'));
            }
            repeater(General)
            {
                Editable = false;
                ShowCaption = false;
                field("Dimension Code 1"; Rec."Dimension Code 1")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Dimension Code 2"; Rec."Dimension Code 2")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                field("Budget Execution"; Rec."Budget Execution")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AfkCalculateBudget)
            {
                ApplicationArea = Suite;
                Caption = 'Calculate Budget';
                Ellipsis = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                trigger OnAction()
                begin

                    AfkBudgetControl.CreatePurchaseBudgetLinesfromTracking(BudgetCode, TaskFilter, NatureFilter, StructureFilter);
                end;
            }
            action(AfkPrintPreview)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Ellipsis = true;
                //Enabled = "No." <> '';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ToolTip = 'calculate special lines based on the tax-free total of the invoice.';

                trigger OnAction()
                var
                    BudgetLine: Record "AfkDocRequisitionBudget";
                    AfkBudgetTracking: Report AfkBudgetTracking;
                begin
                    BudgetLine.SetRange(AfkUserID, UserId);
                    BudgetLine.SetRange(BudgetLine."Document Type", BudgetLine."Document Type"::BudgetTracking);
                    AfkBudgetTracking.SetFiltersValues(BudgetCode, TaskFilter, NatureFilter, StructureFilter);
                    AfkBudgetTracking.SetTableView(BudgetLine);
                    AfkBudgetTracking.Run();
                    //REPORT.Run(REPORT::AfkBudgetTracking, true, false, BudgetLine);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Rec."AfkUserID", UserId);
        Rec.FilterGroup(0);
    end;

    var
        AfkBudgetControl: Codeunit AfkBudgetControl;
        BudgetCode: Code[20];
        NatureFilter: Text[250];
        StructureFilter: Text[250];
        TaskFilter: Text[250];
}
