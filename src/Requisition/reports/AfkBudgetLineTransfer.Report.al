report 50002 AfkBudgetLineTransfer
{
    ApplicationArea = All;
    Caption = 'Budget Line Transfer';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    AllowScheduling = false;


    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 1));

            trigger OnAfterGetRecord()
            var
                BudgetRevision: Codeunit AfkBudgetRevision;
            begin

                if (IsTransfer) then
                    if (AmountToProcess > OriginAvailableAmount) then
                        Error(TransferAmtErr, OriginAvailableAmount);

                if (IsTransfer) then begin
                    if Confirm(StrSubstNo(ConfirmTransferQst, Format(AmountToProcess))) then
                        BudgetRevision.TransferBudgetLine(BudgetCode, OriginTaskCode, OriginNatureCode,
                            DestinationTaskCode, DestinationNatureCode, AmountToProcess,
                            EffectiveDate, OperationReason);
                end else begin
                    if Confirm(StrSubstNo(ConfirmRevisionQst, Format(AmountToProcess))) then
                        BudgetRevision.RevisionBudgetLine(BudgetCode, OriginTaskCode, OriginNatureCode,
                             AmountToProcess, EffectiveDate, OperationReason, RevisionType);
                end;
                ;


            end;

            trigger OnPostDataItem()
            begin

            end;

            trigger OnPreDataItem()
            begin

            end;
        }
    }
    requestpage
    {
        //SaveValues = true;

        layout
        {
            area(content)
            {
                group(Transfer)
                {
                    Caption = 'Transfer';
                    Visible = IsTransfer;
                    field(OriginTaskCode; OriginTaskCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Origin task';
                        ToolTip = 'Code of the task from which you want to perform the transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcOriginAvailableAmount();

                        end;

                    }
                    field(OriginNatureCode; OriginNatureCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Origin nature';
                        ToolTip = 'Code of the Nature from which you want to perform the transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcOriginAvailableAmount();
                        end;
                    }
                    field(OriginAvailableAmount; OriginAvailableAmount)
                    {
                        ApplicationArea = All;
                        Caption = 'Origin Available Amount';
                        Editable = false;
                        ToolTip = 'Amount available on the original budget line';
                        AutoFormatType = 1;
                    }
                    field(DestinationTaskCode; DestinationTaskCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Destination task';
                        ToolTip = 'Code of the task to which you want to transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcDestAvailableAmount();
                        end;
                    }
                    field(DestinationNatureCode; DestinationNatureCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Destination nature';
                        ToolTip = 'Code of the nature to which you want to transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcDestAvailableAmount();
                        end;
                    }
                    field(DestinationAvailableAmount; DestinationAvailableAmount)
                    {
                        ApplicationArea = All;
                        Caption = 'Destination Available Amount';
                        Editable = false;
                        ToolTip = 'Amount available on the destination budget line';
                        AutoFormatType = 1;
                    }
                    field(AmountToTransfer; AmountToProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Amount to transfer';
                        AutoFormatType = 1;
                    }
                    field(TransferReason; OperationReason)
                    {
                        ApplicationArea = All;
                        Caption = 'Transfer Reason';
                    }


                    field(EffectiveDate; EffectiveDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Effective Date';
                    }
                }
                group(Revision)
                {
                    Caption = 'Revision';
                    Visible = not IsTransfer;

                    field(RevisionType; RevisionType)
                    {
                        ApplicationArea = All;
                        Caption = 'Revision type';
                    }
                    field(OriginTaskCodeRev; OriginTaskCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Task';
                        ToolTip = 'Code of the task from which you want to perform the transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcOriginAvailableAmount();
                        end;

                    }
                    field(OriginNatureCodeRev; OriginNatureCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Nature';
                        ToolTip = 'Code of the Nature from which you want to perform the transfer';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
                        trigger OnValidate()
                        begin
                            CalcOriginAvailableAmount();
                        end;
                    }
                    field(OriginAvailableAmountRev; OriginAvailableAmount)
                    {
                        ApplicationArea = All;
                        Caption = 'Available Amount';
                        Editable = false;
                        ToolTip = 'Amount available on the original budget line';
                        AutoFormatType = 1;
                    }

                    field(AmountToTransferRev; AmountToProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Amount';
                        AutoFormatType = 1;
                    }
                    field(TransferReasonRev; OperationReason)
                    {
                        ApplicationArea = All;
                        Caption = 'Reason';
                    }
                    field(EffectiveDateRev; EffectiveDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Effective Date';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if (IsTransfer) then begin
                OperationReason := StrSubstNo(TransferDefaultTxt, Format(Today));
                Caption := TransferTitle;
            end else begin
                OperationReason := StrSubstNo(RevisionDefaultTxt, Format(Today));
                Caption := RevisionTitle;
            end
        end;
    }

    labels
    {
    }
    procedure SetBudgetCode(BudgetCode1: Code[20]; isTransfer1: Boolean)
    begin
        BudgetCode := BudgetCode1;
        IsTransfer := isTransfer1;
    end;

    local procedure CalcOriginAvailableAmount()
    begin
        OriginAvailableAmount := BudgetControl.GetBudgetAmount(BudgetCode, OriginTaskCode, OriginNatureCode);
    end;

    local procedure CalcDestAvailableAmount()
    begin
        DestinationAvailableAmount := BudgetControl.GetBudgetAmount(BudgetCode, DestinationTaskCode, DestinationNatureCode);
    end;

    var
        BudgetControl: Codeunit AfkBudgetControl;
        IsTransfer: Boolean;
        BudgetCode: Code[20];
        DestinationNatureCode: Code[20];
        DestinationTaskCode: Code[20];
        OriginNatureCode: Code[20];
        OriginTaskCode: Code[20];
        EffectiveDate: Date;
        AmountToProcess: Decimal;
        DestinationAvailableAmount: Decimal;
        OriginAvailableAmount: Decimal;
        RevisionType: Enum AfkBudgetRevisionType;
        ConfirmRevisionQst: Label 'Do you want to validate this budgetary revision of %1';
        ConfirmTransferQst: Label 'Do you want to validate this budgetary transfer of %1';
        RevisionDefaultTxt: Label 'Budget Line Revision on %1';
        RevisionTitle: Label 'Budget Line Revision';
        TransferAmtErr: Label 'You cannot transfer more than %1';
        TransferDefaultTxt: Label 'Budget Line Transfer on %1';
        TransferTitle: Label 'Budget Line Transfer';
        OperationReason: Text[100];
        TitleCaption: Text[100];
}
