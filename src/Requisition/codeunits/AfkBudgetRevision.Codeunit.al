codeunit 50007 AfkBudgetRevision
{

    procedure TransferBudgetLine(
        BudgetCode: Code[20];
        OriginTaskCode: Code[20];
        OriginNatureCode: Code[20];
        DestinationTaskCode: Code[20];
        DestinationNatureCode: Code[20];
        AmountToTransfer: Decimal;
        EffectiveDate: Date;
        TransferReason: Text[100])
    begin
        CheckDataForTransfer(OriginTaskCode, OriginNatureCode, DestinationTaskCode,
            DestinationNatureCode, AmountToTransfer, TransferReason);

        ProcessTransfer(BudgetCode, OriginTaskCode, OriginNatureCode, DestinationTaskCode,
            DestinationNatureCode, AmountToTransfer, EffectiveDate, TransferReason);
    end;

    procedure RevisionBudgetLine(
      BudgetCode: Code[20];
      OriginTaskCode: Code[20];
      OriginNatureCode: Code[20];
      AmountToProcess: Decimal;
      EffectiveDate: Date;
      Reason: Text[100];
      BudgetRevisionType: Enum AfkBudgetRevisionType)
    begin
        CheckDataForRevision(OriginTaskCode, OriginNatureCode,
             AmountToProcess, Reason);

        ProcessRevision(BudgetCode, OriginTaskCode, OriginNatureCode,
            AmountToProcess, EffectiveDate, Reason, BudgetRevisionType);
    end;

    local procedure CheckDataForTransfer(OriginTaskCode: Code[20]; OriginNatureCode:
    Code[20]; DestinationTaskCode: Code[20]; DestinationNatureCode: Code[20];
    AmountToTransfer: Decimal;
    TransferReason: Text[100])
    var
        DimValueDest: Record "Dimension Value";
        DimValueOr: Record "Dimension Value";
    begin
        GLSetup.Get();
        if (OriginTaskCode = '') then Error(InvalidOriginTaskCodeErr);
        if (OriginNatureCode = '') then Error(InvalidOriginNatureCodeErr);
        if (DestinationTaskCode = '') then Error(InvalidDestinationTaskCodeErr);
        if (DestinationNatureCode = '') then Error(InvalidDestinationNatureCodeErr);
        if (AmountToTransfer <= 0) then Error(InvalidAmountToTransferErr);
        if (TransferReason = '') then Error(InvalidTransferReasonCodeErr);
        DimValueOr.Get(GLSetup."Global Dimension 1 Code", OriginTaskCode);
        DimValueDest.Get(GLSetup."Global Dimension 1 Code", DestinationTaskCode);
        if (DimValueOr.AfkBudgetTaskType <> DimValueDest.AfkBudgetTaskType) then
            Error(DiffTaskTypeErr);
        if ((OriginTaskCode = DestinationTaskCode) and (OriginNatureCode = DestinationNatureCode)) then
            Error(SameAccountForTransferErr);

    end;

    local procedure CheckDataForRevision(OriginTaskCode: Code[20]; OriginNatureCode:
        Code[20];
        AmountToProcess: Decimal; Reason: Text[100])
    begin
        if (OriginTaskCode = '') then Error(InvalidOriginTaskCodeErr);
        if (OriginNatureCode = '') then Error(InvalidOriginNatureCodeErr);
        if (AmountToProcess <= 0) then Error(InvalidAmountToTransferErr);
        if (Reason = '') then Error(InvalidTransferReasonCodeErr);
    end;



    local procedure ProcessRevision(BudgetCode: Code[20]; OriginTaskCode: Code[20]; OriginNatureCode: Code[20];
        AmountToProcess: Decimal; EffectiveDate: Date; Reason: Text[100];
        RevisionType: Enum AfkBudgetRevisionType)
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin

        UserSetup.Get(UserId);
        if (not UserSetup.Afk_CanValidateBudgetRevision) then
            Error(CannotTransferBudgetErr);

        AfkSetup.Get();
        AfkSetup.TestField("Default Budget Code");
        AfkSetup.TestField(BudgetGLAccount);

        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := 0;
        GLBudgetEntry.Validate("Global Dimension 1 Code", OriginTaskCode);
        GLBudgetEntry.Validate("Global Dimension 2 Code", OriginNatureCode);
        GLBudgetEntry.Validate("G/L Account No.", AfkSetup.BudgetGLAccount);

        if ((RevisionType = RevisionType::Initial) or (RevisionType = RevisionType::Increase)) then
            GLBudgetEntry.Validate(Amount, AmountToProcess)
        else
            GLBudgetEntry.Validate(Amount, -AmountToProcess);

        if (RevisionType = RevisionType::Initial) then
            GLBudgetEntry.Afk_Operation_Type := GLBudgetEntry.Afk_Operation_Type::Initial;
        if (RevisionType = RevisionType::Increase) then
            GLBudgetEntry.Afk_Operation_Type := GLBudgetEntry.Afk_Operation_Type::Increase;
        if (RevisionType = RevisionType::Decrease) then
            GLBudgetEntry.Afk_Operation_Type := GLBudgetEntry.Afk_Operation_Type::Decrease;

        GLBudgetEntry."Budget Name" := BudgetCode;
        GLBudgetEntry.Description := Reason;
        if (EffectiveDate = 0D) then
            GLBudgetEntry.Validate(Date, BudgetControl.GetStartOfYear(Today))
        else
            GLBudgetEntry.Validate(Date, EffectiveDate);
        GLBudgetEntry.Insert(true);


    end;

    local procedure ProcessTransfer(BudgetCode: Code[20]; OriginTaskCode: Code[20]; OriginNatureCode: Code[20];
        DestinationTaskCode: Code[20]; DestinationNatureCode: Code[20];
        AmountToTransfer: Decimal; EffectiveDate: Date; TransferReason: Text[100])
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin

        UserSetup.Get(UserId);
        if (not UserSetup.Afk_CanValidateBudgetTransfer) then
            Error(CannotTransferBudgetErr);

        AfkSetup.Get();
        AfkSetup.TestField("Default Budget Code");
        AfkSetup.TestField(BudgetGLAccount);

        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := 0;
        GLBudgetEntry.Validate("Global Dimension 1 Code", OriginTaskCode);
        GLBudgetEntry.Validate("Global Dimension 2 Code", OriginNatureCode);
        GLBudgetEntry.Validate("G/L Account No.", AfkSetup.BudgetGLAccount);
        GLBudgetEntry.Validate(Amount, -AmountToTransfer);
        GLBudgetEntry."Budget Name" := BudgetCode;
        GLBudgetEntry.Description := TransferReason;
        GLBudgetEntry.Afk_Operation_Type := GLBudgetEntry.Afk_Operation_Type::Transfer;
        if (EffectiveDate = 0D) then
            GLBudgetEntry.Validate(Date, BudgetControl.GetStartOfYear(Today))
        else
            GLBudgetEntry.Validate(Date, EffectiveDate);
        GLBudgetEntry.Insert(true);


        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := 0;
        GLBudgetEntry.Validate("Global Dimension 1 Code", DestinationTaskCode);
        GLBudgetEntry.Validate("Global Dimension 2 Code", DestinationNatureCode);
        GLBudgetEntry.Validate("G/L Account No.", AfkSetup.BudgetGLAccount);
        GLBudgetEntry.Validate(Amount, AmountToTransfer);
        GLBudgetEntry."Budget Name" := BudgetCode;
        GLBudgetEntry.Description := TransferReason;
        GLBudgetEntry.Afk_Operation_Type := GLBudgetEntry.Afk_Operation_Type::Transfer;
        if (EffectiveDate = 0D) then
            GLBudgetEntry.Validate(Date, BudgetControl.GetStartOfYear(Today))
        else
            GLBudgetEntry.Validate(Date, EffectiveDate);
        GLBudgetEntry.Insert(true);
    end;



    var
        AfkSetup: Record AfkSetup;
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        BudgetControl: Codeunit AfkBudgetControl;
        CannotTransferBudgetErr: Label 'You do not have permissions to perform this operation';
        DiffTaskTypeErr: Label 'Please select two tasks of the same type for this transfer';
        InvalidAmountToTransferErr: Label 'Invalid Amount to transfer';
        InvalidDestinationNatureCodeErr: Label 'Invalid Destination Nature Code';
        InvalidDestinationTaskCodeErr: Label 'Invalid Destination Task Code';
        InvalidOriginNatureCodeErr: Label 'Invalid Origin Nature Code';
        InvalidOriginTaskCodeErr: Label 'Invalid Origin Task Code';
        InvalidTransferReasonCodeErr: Label 'Please enter a valid Reason';
        SameAccountForTransferErr: Label 'Please select differents task and nature for this transfer';
}
