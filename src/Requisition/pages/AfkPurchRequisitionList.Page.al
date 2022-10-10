page 50008 "AfkPurchRequisitionList"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Purchase Requisition List';
    CardPageID = AfkPurchaseRequisition;
    Editable = false;
    PageType = List;
    SourceTable = "AfkDocRequisition";
    SourceTableView = WHERE("Document Type" = FILTER(Requisition));
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Approbation,Release,Request Approval,Purchase Requisition';


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SystemCreatedAt; rec.SystemCreatedAt)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Budget Code"; rec."Budget Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }


            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit AfkPRReqWorkflowMgt;
                begin
                    ApprovalsMgmt.OpenApprovalsEmplLoan(Rec);
                end;

            }
        }
        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                //Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = All, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';
                    Promoted = true;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Enabled = NOT OpenApprovalEntriesExist;
                    trigger OnAction()
                    var
                        EmpLoanWkflMgt: Codeunit AfkPRReqWorkflowMgt;
                    begin
                        IF EmpLoanWkflMgt.CheckDocRequisitionApprovalPossible_AFK(Rec) THEN;
                        EmpLoanWkflMgt.OnSendPurchRequisitionForApproval_AFK(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Enabled = CanCancelApprovalForRecord;
                    trigger OnAction()
                    var
                        EmpLoanWkflMgt: Codeunit AfkPRReqWorkflowMgt;
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        EmpLoanWkflMgt.OnCancelPurchRequisitionApprovalRequest_AFK(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RECORDID);
                    end;
                }
            }
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                    begin
                        Rec.PerformManualRelease();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                    begin
                        Rec.PerformManualReOpen();
                    end;
                }
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    var
    begin
        SetControlAppearance();
    end;


    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;

        OpenApprovalEntriesExistForCurrUser: Boolean;

    local procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;




}

