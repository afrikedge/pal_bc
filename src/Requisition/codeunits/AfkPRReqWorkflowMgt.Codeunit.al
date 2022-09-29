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
        WEventHandling.AddEventToLibrary(GetOnSendDocRequisitionForApprovalCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionSendForApprovalEventDescTxt_AFK, 0, FALSE);
        WEventHandling.AddEventToLibrary(GetOnAfterReleaseDocRequisitionCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionReleasedEventDescTxt_AFK, 0, FALSE);
        WEventHandling.AddEventToLibrary(GetOnCancelDocRequisitionApprovalRequestCode, DATABASE::"AfkPurchaseRequisition",
            PurchRequisitionApprReqCancelledEventDescTxt_AFK, 0, FALSE);
    end;

    procedure AddWorkflowEventPredecessorsToLibrary(var EventFunctionName: code[128])

    begin
        case EventFunctionName of
            GetOnCancelDocRequisitionApprovalRequestCode:
                WEventHandling.AddEventPredecessor(GetOnCancelDocRequisitionApprovalRequestCode, GetOnSendDocRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnApproveApprovalRequestCode, GetOnSendDocRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnRejectApprovalRequestCode, GetOnSendDocRequisitionForApprovalCode);
            WEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                WEventHandling.AddEventPredecessor(WEventHandling.RunWorkflowOnDelegateApprovalRequestCode, GetOnSendDocRequisitionForApprovalCode);
        end;
    end;


    procedure HandleOnCancePurchRequisitionApprovalRequest(var PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        WorkflowManagement.HandleEvent(GetOnCancelDocRequisitionApprovalRequestCode, PurchRequisition);
    end;

    procedure HandleOnSendPurchRequisitionForApproval(var PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        WorkflowManagement.HandleEvent(GetOnSendDocRequisitionForApprovalCode, PurchRequisition);
    end;

    procedure OpenApprovalsEmplLoan(EmpLoan: Record AfkPurchaseRequisition)
    begin
        ApprovMgt.RunWorkflowEntriesPage(
              EmpLoan.RecordId(), DATABASE::AfkPurchaseRequisition, Enum::"Approval Document Type"::" ", EmpLoan."No.");
    end;

    procedure SetStatusToPendingApproval(RecRef: RecordRef; Variant: Variant; var IsHandled: Boolean)
    var
        DocRequisition: Record "AfkPurchaseRequisition";
    begin
        case RecRef.Number of
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(DocRequisition);
                    DocRequisition.VALIDATE(Status, DocRequisition.Status::"Pending Approval");
                    DocRequisition.MODIFY(TRUE);
                    Variant := DocRequisition;
                    IsHandled := true;
                end;
        end;
    end;

    procedure ReleaseRequisitionDoc(RecRef: RecordRef; VAR Handled: Boolean)
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

    procedure ShowRequisitionApprovalStatus_AFK(PurchRequisition: Record "AfkPurchaseRequisition")
    begin
        PurchRequisition.FIND;

        CASE PurchRequisition.Status OF
            PurchRequisition.Status::Released:
                MESSAGE(DocStatusChangedMsg, ReqTypeDocumentText_AFK, PurchRequisition."No.", PurchRequisition.Status);
            PurchRequisition.Status::"Pending Approval":
                IF ApprovMgt.HasOpenOrPendingApprovalEntries(PurchRequisition.RECORDID) THEN
                    MESSAGE(PendingApprovalMsg);
        END;
    end;

    local procedure CalcPurchRequisitionAmount_AFK(DocRequisition: Record "AfkPurchaseRequisition"; VAR ApprovalAmount: Decimal; VAR ApprovalAmountLCY: Decimal)
    begin
        ApprovalAmount := DocRequisition."Amount Including VAT";
        ApprovalAmountLCY := DocRequisition."Amount (LCY)";
    end;

    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; VAR ApprovalEntryArgument: Record "Approval Entry")
    var
        DocRequisition: Record "AfkPurchaseRequisition";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
    begin

        CASE RecRef.NUMBER OF
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(DocRequisition);
                    CalcPurchRequisitionAmount_AFK(DocRequisition, ApprovalAmount, ApprovalAmountLCY);
                    ApprovalEntryArgument."Document No." := DocRequisition."No.";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := DocRequisition."Currency Code";
                end;
        end;
    end;


    procedure IsSufficientApprover(UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; var IsSufficient: Boolean)
    begin
        CASE ApprovalEntryArgument."Table ID" OF
            DATABASE::"AfkPurchaseRequisition":
                IsSufficient := IsSufficientDocRequisitionApprover_AFK(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;

    local procedure IsSufficientDocRequisitionApprover_AFK(UserSetup: Record "User Setup"; ApprovalAmountLCY: Decimal): Boolean
    begin
        IF UserSetup."User ID" = UserSetup."Approver ID" THEN
            EXIT(true);

        IF UserSetup."AfkUnlimitedPRApproval" OR
            ((ApprovalAmountLCY <= UserSetup."AfkPRAmountApprovalLimit") AND (UserSetup."AfkPRAmountApprovalLimit" <> 0))
        THEN
            exit(true);


        exit(false);
    end;

    procedure IsDocRequisitionApprovalsWorkflowEnabled_AFK(var DocRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        EXIT(WorkflowManagement.CanExecuteWorkflow(DocRequisition, GetOnSendDocRequisitionForApprovalCode));
    end;

    procedure IsDocRequisitionPendingApproval_AFK(var DocRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        IF DocRequisition.Status <> DocRequisition.Status::Open THEN
            EXIT(FALSE);

        EXIT(IsDocRequisitionApprovalsWorkflowEnabled_AFK(DocRequisition));
    end;

    procedure CheckDocRequisitionApprovalPossible_AFK(var DocRequisition: Record "AfkPurchaseRequisition"): Boolean
    begin
        IF NOT IsDocRequisitionApprovalsWorkflowEnabled_AFK(DocRequisition) THEN
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    procedure ShowCommonApprovalStatus(var RecRef: RecordRef; var IsHandle: Boolean)
    var
        DocRequisition: Record "AfkPurchaseRequisition";
    begin

        CASE RecRef.NUMBER OF
            DATABASE::"AfkPurchaseRequisition":
                begin
                    RecRef.SETTABLE(DocRequisition);
                    ShowRequisitionApprovalStatus_AFK(DocRequisition);
                    IsHandle := true;
                end;
        end;
    end;

    procedure GetOnSendDocRequisitionForApprovalCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendDocRequisitionForApproval'));
    end;

    local procedure GetOnAfterReleaseDocRequisitionCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseDocRequisition'));
    end;

    local procedure GetOnCancelDocRequisitionApprovalRequestCode(): Text[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelDocRequisitionApprovalRequest'));
    end;


    var
        ApprovMgt: Codeunit "Approvals Mgmt.";
        WorkflowManagement: Codeunit "Workflow Management";
        WEventHandling: Codeunit "Workflow Event Handling";
        ReqTypeDocumentText_AFK: Label 'Employee loan';
        DocStatusChangedMsg: Label '%1 %2 has been automatically approved. The status has been changed to %3.';
        PendingApprovalMsg: Label 'An approval request has been sent.';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        PurchRequisitionSendForApprovalEventDescTxt_AFK: Label 'Approval of a requisition document is requested.';
        PurchRequisitionReleasedEventDescTxt_AFK: Label 'A requisition document is released.';
        PurchRequisitionApprReqCancelledEventDescTxt_AFK: Label 'An approval request for a requisition document is cancelled.';

}