page 50006 "AfkItemRequisition"
{
    Caption = 'Item Requisition';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "AfkDocRequisition";
    SourceTableView = WHERE("Document Type" = FILTER("ItemReq"));
    UsageCategory = Documents;
    PromotedActionCategories = 'New,Process,Report,Approbation,Release,Request Approval';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    ToolTip = 'Specifies the number of the Item requisition.';
                    Editable = false;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Lookup = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Editable = false;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Editable = CanEdit;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CanEdit;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Requested Receipt Date"; Rec."Requested Receipt Date")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Editable = CanEdit;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            part(Lines; "AfkItemRequisitionSubform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = FIELD("No.");
            }
            part(AfkBudgetLines; AfkBudgetLinesSubForm)
            {
                Caption = 'Budget summary';
                ApplicationArea = Suite;
                SubPageLink = "Document No." = field("No.");
                //UpdatePropagation = Both;
            }

        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
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
        area(navigation)
        {
            group("&Header")
            {
                Caption = '&Header';
                Image = Purchasing;
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ToolTip = 'View or change the dimension settings for this payment slip. If you change the dimension, you can update all lines on the payment slip.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit AfkPRReqWorkflowMgt;
                begin
                    ApprovalsMgmt.OpenApprovalsEmplLoan(Rec);
                end;
            }

        }
        area(processing)
        {
            group("Approbation")
            {
                Caption = '&Approval';
                //Image = Approvals;
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;

                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Promoted = true;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
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
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                    begin
                        if (Rec.Status = Rec.Status::Released) then
                            Error('');
                        Rec.PerformManualReOpen();
                    end;
                }
            }
            group(Action22)
            {
                Caption = 'Actions';
                action(AfkCalculateBudget)
                {
                    ApplicationArea = Suite;
                    Caption = 'Calculate Budget';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        AfkBudgetControl.CreatePurchaseBudgetLines_ItemReq(Rec, false);
                    end;
                }
                action(AfkCloseDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Close Document';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        AfkItemReqMgt.CancelItemRequisition(Rec);
                    end;
                }
                action(AfkPostDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create new delivery';
                    Ellipsis = true;
                    Enabled = IsRelease;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    //ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        AfkItemReqMgt.PostNewItemDelivery(Rec);
                    end;
                }
                action("DeliveryForms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delivery List';
                    Image = ItemLedger;
                    RunObject = Page "AfkWhseDeliveryList";
                    RunPageLink = "External Doc No" = FIELD("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunPageView = SORTING("Item No.")
                    //                      ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    //ToolTip = 'View the history of transactions that have been posted for the selected document.';
                }

            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        CanEdit := Rec.Status = Rec.Status::Open;
        IsRelease := Rec.Status = Rec.Status::Released;
        CurrPage.Lines.PAGE.Editable(true);
        SetControlVisibility();

    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        CanEdit := Rec.Status = Rec.Status::Open;
        IsRelease := Rec.Status = Rec.Status::Released;
        SetControlAppearance();
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);

    end;


    var
        PaymentStep: Record "Payment Step";
        AfkBudgetControl: Codeunit AfkBudgetControl;
        AfkItemReqMgt: Codeunit AfkItemReqMgt;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Navigate: Page Navigate;
        CanCancelApprovalForRecord: Boolean;
        CanEdit: Boolean;
        IsRelease: Boolean;
        OpenApprovalEntriesExist: Boolean;

        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        Text001: Label 'This payment class does not authorize vendor suggestions.';
        Text002: Label 'This payment class does not authorize customer suggestions.';
        Text003: Label 'You cannot suggest payments on a posted header.';
        Text009: Label 'Do you want to archive this document?';

    local procedure SetControlVisibility()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    local procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;



    local procedure DocumentDateOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;
}

