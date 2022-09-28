codeunit 50005 AfkPRReqWorkflowMgt
{

    [IntegrationEvent(false, false)]
    procedure OnSendPurchRequisitionForApproval_AFK(PurchRequisition: Record "AfkPurchaseRequisition")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPurchRequisitionApprovalRequest_AFK(PurchRequisition: Record "AfkPurchaseRequisition")
    begin
    end;

    procedure AddWorkflowEventsToLibrary()

    begin
        WEventHandling.AddEventToLibrary(GetOnSendPurchRequisitionForApprovalCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionSendForApprovalEventDescTxt_AFK, 0, FALSE);
        WEventHandling.AddEventToLibrary(GetOnAfterReleasePurchRequisitionCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionReleasedEventDescTxt_AFK, 0, FALSE);
        WEventHandling.AddEventToLibrary(GetOnCancelPurchRequisitionApprovalRequestCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionApprReqCancelledEventDescTxt_AFK, 0, FALSE);
    end;

    procedure AddWorkflowEventPredecessorsToLibrary(var EventFunctionName: code[128])

    begin
        case EventFunctionName of
            GetOnCancelPurchRequisitionApprovalRequestCode:
                WEventHandling.AddEventPredecessor(GetOnCancelPurchRequisitionApprovalRequestCode, GetOnSendPurchRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnApproveApprovalRequestCode, GetOnSendPurchRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnRejectApprovalRequestCode, GetOnSendPurchRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnDelegateApprovalRequestCode, GetOnSendPurchRequisitionForApprovalCode);
        end;
    end;


    procedure HandleOnCancePurchRequisitionApprovalRequest(var PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        WorkflowManagement.HandleEvent(GetOnCancelPurchRequisitionApprovalRequestCode, PurchRequisition);
    end;

    procedure HandleOnSendPurchRequisitionForApproval(var PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        WorkflowManagement.HandleEvent(GetOnSendPurchRequisitionForApprovalCode, PurchRequisition);
    end;

    procedure OpenApprovalsEmplLoan(EmpLoan: Record AfkPurchaseRequisition)
    begin
        ApprovMgt.RunWorkflowEntriesPage(
              EmpLoan.RecordId(), DATABASE::AfkPurchaseRequisition, Enum::"Approval Document Type"::" ", EmpLoan."No.");
    end;

    procedure SetStatusToPendingApproval(RecRef: RecordRef; Variant: Variant; var IsHandled: Boolean)
    var
        PurchRequisition: Record "AfkPurchaseRequisition";
    begin
        case RecRef.Number of
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(PurchRequisition);
                    PurchRequisition.VALIDATE(Status, PurchRequisition.Status::"Pending Approval");
                    PurchRequisition.MODIFY(TRUE);
                    Variant := PurchRequisition;
                    IsHandled := true;
                end;
        end;
    end;

    procedure ReleasePurchRequisitionDoc(RecRef: RecordRef; VAR Handled: Boolean)
    var
        PurchRequisition: Record "AfkPurchaseRequisition";
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(PurchRequisition);
                    PurchRequisition.PerformManualRelease();
                    Handled := true;
                end;
        end;
    end;

    procedure ShowPurchRequisitionApprovalStatus_AFK(PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        PurchRequisition.FIND;

        CASE PurchRequisition.Status OF
            PurchRequisition.Status::Released:
                MESSAGE(DocStatusChangedMsg, LoanTypeDocumentText_AFK, PurchRequisition."No.", PurchRequisition.Status);
            PurchRequisition.Status::"Pending Approval":
                IF ApprovMgt.HasOpenOrPendingApprovalEntries(PurchRequisition.RECORDID) THEN
                    MESSAGE(PendingApprovalMsg);
        END;
    end;

    local procedure CalcPurchRequisitionAmount_AFK(PurchRequisition: Record "AfkPurchaseRequisition"; VAR ApprovalAmount: Decimal; VAR ApprovalAmountLCY: Decimal)
    begin
        ApprovalAmount := PurchRequisition."Amount Including VAT";
        ApprovalAmountLCY := PurchRequisition."Amount (LCY)";
    end;

    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; VAR ApprovalEntryArgument: Record "Approval Entry")
    var
        PurchRequisition: Record "AfkPurchaseRequisition";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
    begin

        CASE RecRef.NUMBER OF
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(PurchRequisition);
                    CalcPurchRequisitionAmount_AFK(PurchRequisition, ApprovalAmount, ApprovalAmountLCY);
                    ApprovalEntryArgument."Document No." := PurchRequisition."No.";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PurchRequisition."Currency Code";
                end;
        end;
    end;


    procedure IsSufficientApprover(UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; var IsSufficient: Boolean)
    begin
        CASE ApprovalEntryArgument."Table ID" OF
            DATABASE::"AfkPurchaseRequisition":
                IsSufficient := IsSufficientPurchRequisitionApprover_AFK(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;

    local procedure IsSufficientPurchRequisitionApprover_AFK(UserSetup: Record "User Setup"; ApprovalAmountLCY: Decimal): Boolean
    begin
        IF UserSetup."User ID" = UserSetup."Approver ID" THEN
            EXIT(true);

        IF UserSetup."Unlimited PR Approval" OR
            ((ApprovalAmountLCY <= UserSetup."PR Amount Approval Limit") AND (UserSetup."PR Amount Approval Limit" <> 0))
        THEN
            exit(true);


        exit(false);
    end;

    procedure IsPurchRequisitionApprovalsWorkflowEnabled_AFK(var PurchRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(PurchRequisition, GetOnSendPurchRequisitionForApprovalCode));
    end;

    procedure IsPurchRequisitionPendingApproval_AFK(var PurchRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        IF PurchRequisition.Status <> PurchRequisition.Status::Open THEN
            EXIT(FALSE);

        EXIT(IsPurchRequisitionApprovalsWorkflowEnabled_AFK(PurchRequisition));
    end;

    procedure CheckPurchRequisitionApprovalPossible_AFK(var PurchRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        IF NOT IsPurchRequisitionApprovalsWorkflowEnabled_AFK(PurchRequisition) THEN
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    procedure ShowCommonApprovalStatus(var RecRef: RecordRef; var IsHandle: Boolean)
    var
        PurchRequisition: Record "AfkPurchaseRequisition";
    begin

        CASE RecRef.NUMBER OF
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(PurchRequisition);
                    ShowPurchRequisitionApprovalStatus_AFK(PurchRequisition);
                    IsHandle := true;
                end;
        end;
    end;

    procedure GetOnSendPurchRequisitionForApprovalCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendPurchRequisitionForApproval'));
    end;

    local procedure GetOnAfterReleasePurchRequisitionCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleasePurchRequisition'));
    end;

    local procedure GetOnCancelPurchRequisitionApprovalRequestCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelPurchRequisitionApprovalRequest'));
    end;


    var
        ApprovMgt: Codeunit "Approvals Mgmt.";
        WorkflowManagement: Codeunit "Workflow Management";
        WEventHandling: Codeunit "Workflow Event Handling";
        LoanTypeDocumentText_AFK: Label 'Employee loan';
        DocStatusChangedMsg: Label '%1 %2 has been automatically approved. The status has been changed to %3.';
        PendingApprovalMsg: Label 'An approval request has been sent.';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        PurchRequisitionSendForApprovalEventDescTxt_AFK: Label 'Approval of a loan document is requested.';
        PurchRequisitionReleasedEventDescTxt_AFK: Label 'A loan document is released.';
        PurchRequisitionApprReqCancelledEventDescTxt_AFK: Label 'An approval request for a loan document is canceled.';

}