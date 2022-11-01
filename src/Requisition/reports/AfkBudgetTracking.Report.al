report 50005 AfkBudgetTracking
{
    ApplicationArea = All;
    Caption = 'Budget Tracking';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/requisition/reports/layouts/AfkBudgetTracking.rdlc';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(AfkDocRequisitionBudget; AfkDocRequisitionBudget)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "G/L Account No", "Dimension Code 1");

            column(BudgetFilter; BudgetFilter)
            {
            }
            column(TaskFilter; TaskFilter)
            {
            }
            column(NatureFilter; NatureFilter)
            {
            }
            column(NatureFilterLbl; NatureFilterLbl)
            {
            }
            column(BudgetFilterLbl; BudgetFilterLbl)
            {
            }
            column(ReportTitleLbl; ReportTitleLbl)
            {
            }
            column(TaskFilterLbl; TaskFilterLbl)
            {
            }

            column(DimensionCode1; "Dimension Code 1")
            {
            }
            column(GLAccountNo; "G/L Account No")
            {
            }
            column(YearlyBudgetedAmt; "Yearly Budgeted Amt")
            {
            }
            column(YearlyPreCommitment; "Yearly PreCommitment")
            {
            }
            column(YearlyCommitment; "Yearly Commitment")
            {
            }
            column(YearlyRealizedAmt; "Yearly Realized Amt")
            {
            }
            column(YearlyAvailableAmt; "Yearly Available Amt")
            {
            }
            column(TaskCodeLbl; TaskCodeLbl)
            {
            }
            column(NatureCodeLbl; NatureCodeLbl)
            {
            }
            column(BudgetedLbl; BudgetedLbl)
            {
            }
            column(PreCommitmentLbl; PreCommitmentLbl)
            {
            }
            column(CommitmentLbl; CommitmentLbl)
            {
            }
            column(RealizedLbl; RealizedLbl)
            {
            }
            column(AvailableLbl; AvailableLbl)
            {
            }
            column(AfkCompanyPicture; CompanyInformation.Picture)
            {
            }



            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                AfkDocRequisitionBudget.FilterGroup(2);
                AfkDocRequisitionBudget.SetRange("AfkUserID", UserId);
                AfkDocRequisitionBudget.FilterGroup(0);

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInformation: Record "Company Information";
        AvailableLbl: Label 'Yearly Available Amt';
        BudgetedLbl: Label 'Yearly Budgeted Amt';
        BudgetFilterLbl: Label 'Budget filter';
        CommitmentLbl: Label 'Yearly Commitment';
        NatureCodeLbl: Label 'Nature';

        NatureFilterLbl: Label 'Nature filter';
        PreCommitmentLbl: Label 'Yearly Pre-Commitment';
        RealizedLbl: Label 'Yearly Realized Amt';
        ReportTitleLbl: Label 'Budget Tracking';
        TaskCodeLbl: Label 'Task Code';
        TaskFilterLbl: Label 'Task filter';
        BudgetFilter: Text[100];
        NatureFilter: Text[100];
        TaskFilter: Text[100];

    procedure SetFiltersValues(BudgetFilter1: Text[100]; TaskFilter1: Text[100]; NatureFilter1: Text[100])
    begin
        BudgetFilter := BudgetFilter1;
        TaskFilter := TaskFilter1;
        NatureFilter := NatureFilter1;
    end;
}
