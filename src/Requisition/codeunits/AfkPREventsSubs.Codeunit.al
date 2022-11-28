codeunit 50006 AfkPREventsSubs
{
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddEmployeeLoanWorkflowEventsToLibrary()
    begin
        EmplLoanWkflMgt.AddWorkflowEventsToLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEmplLoanEventPredecessors(EventFunctionName: code[128])
    begin
        EmplLoanWkflMgt.AddWorkflowEventPredecessorsToLibrary(EventFunctionName);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"AfkPRReqWorkflowMgt", 'OnSendPurchRequisitionForApproval_AFK', '', false, false)]
    local procedure RunWorkflowOnSendEmployeeLoanForApproval(PurchRequisition: Record "AfkDocRequisition")
    begin
        EmplLoanWkflMgt.HandleOnSendPurchRequisitionForApproval(PurchRequisition);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"AfkPRReqWorkflowMgt", 'OnCancelPurchRequisitionApprovalRequest_AFK', '', false, false)]
    local procedure RunWorkflowOnCanceEmployeeLoanApprovalRequest_AFK(PurchRequisition: Record "AfkDocRequisition")
    begin
        EmplLoanWkflMgt.HandleOnCancePurchRequisitionApprovalRequest(PurchRequisition);
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(VAR RecRef: RecordRef; VAR ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    begin
        EmplLoanWkflMgt.PopulateApprovalEntryArgument(RecRef, WorkflowStepInstance, ApprovalEntryArgument);
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterIsSufficientApprover', '', false, false)]
    local procedure CheckIsSufficientApprover(UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; VAR IsSufficient: Boolean)
    begin
        EmplLoanWkflMgt.IsSufficientApprover(UserSetup, ApprovalEntryArgument, IsSufficient);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure SetEmployeeLoanStatusToPendingAppr(RecRef: RecordRef; VAR Variant: Variant; VAR IsHandled: Boolean)
    begin
        EmplLoanWkflMgt.SetStatusToPendingApproval(RecRef, Variant, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeShowCommonApprovalStatus', '', false, false)]
    local procedure ShowPurchReqCommonApprStatus(var RecRef: RecordRef; var IsHandle: Boolean)
    begin
        EmplLoanWkflMgt.ShowCommonApprovalStatus(RecRef, IsHandle);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        EmplLoanWkflMgt.ReleaseRequisitionDoc(RecRef, Handled);
    end;

    // [IntegrationEvent(false, false)]
    //     local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    //     begin
    //     end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        EmplLoanWkflMgt.ReOpenRequisitionDoc(RecRef, Handled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnBeforeGetConditionalCardPageID', '', false, false)]
    local procedure OnBeforeGetConditionalCardPageID(RecRef: RecordRef; var CardPageID: Integer; var IsHandled: Boolean)
    begin
        EmplLoanWkflMgt.OnBeforeGetConditionalCardPageID(RecRef, CardPageID, IsHandled);
    end;





    var
        EmplLoanWkflMgt: codeunit AfkPRReqWorkflowMgt;


}