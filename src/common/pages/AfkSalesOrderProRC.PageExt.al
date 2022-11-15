pageextension 50004 AfkSalesOrderProRC extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group(Afk_AddOns)
            {
                Caption = 'AfkSales';
                Image = Sales;
                ToolTip = 'Port Services Managment';
                action(AfkBoatTypes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Boat Types';
                    Image = Track;
                    RunObject = Page AfkBoatTypes;
                    ToolTip = 'View or edit detailed information for the boat types';
                }
                action(AfkItems)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = ItemLines;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information about services';
                }
                action(AfkCustomers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = CustomerList;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information about customers';
                }
                action(AfkBoats)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Boats';
                    Image = Track;
                    RunObject = Page AfkBoatList;
                    ToolTip = 'View or edit detailed information for the boats';
                }
                action(AfkCalcParameters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculation Parameters';
                    Image = Track;
                    RunObject = Page AfkCalcParameters;
                    ToolTip = 'View or edit detailed information for the calculation parameters';
                }
                action(AfkPricing)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Port Services pricing';
                    Image = Track;
                    RunObject = Page AfkSalesInvPricing;
                    ToolTip = 'View or edit detailed information for the pricing of port services';
                }
                action(AfkPSalesInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = SalesInvoice;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'View or edit detailed information about sales invoices';
                }
                action(AfkSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup';
                    Image = Setup;
                    RunObject = Page AfkSetupCard;
                    ToolTip = 'View or edit setup parameters';
                }
                action(AfkSalesStandardCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Sales Codes';
                    Image = Sales;
                    RunObject = Page "Standard Sales Codes";
                    //ToolTip = 'View or edit setup parameters';
                }
                action(AfkCreateSalesStandardCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Recurring Sales Invoice';
                    Image = CreateDocuments;
                    RunObject = Report "Create Recurring Sales Inv.";
                    //ToolTip = 'View or edit setup parameters';
                }

            }
        }
        addafter(Afk_AddOns)
        {
            group(Afk_AddOns2)
            {
                Caption = 'AfkPurchase';
                Image = Sales;
                ToolTip = 'Purchase and Budget Managment';

                action(AfkDimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Dimensions";
                    ToolTip = 'View or edit detailed information about dimensions';
                }
                action(AfkBudgets)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Budget Names';
                    Image = CostBudget;
                    RunObject = Page "G/L Budget Names";
                    ToolTip = 'View or edit detailed information about budgets';
                }
                action(AfkPRDocs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase requests';
                    Image = PurchaseInvoice;
                    RunObject = Page "Purchase quotes";
                    ToolTip = 'View or edit detailed information about purchase requests';
                }
                action(AfkPODocs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase commitments';
                    Image = Purchase;
                    RunObject = Page "Purchase order list";
                    ToolTip = 'View or edit detailed information about commitments';
                }
                action(AfkItems2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = ItemLines;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information about services';
                }
                action(AfkVendors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    Image = CustomerList;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information about vendors';
                }
                action(AfkUserSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    Image = Setup;
                    RunObject = Page "User Setup";
                }
                action(AfkBudgetTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Tracking';
                    Image = CostBudget;
                    RunObject = Page AfkBudgetTracking;
                }
                action("AfkPurchaseQuoteArchive")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Quote Archives';
                    RunObject = page "Purchase Quote Archives";
                }
                action("AfkPurchaseOrderArchive")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order Archives';
                    RunObject = page "Purchase Order Archives";
                }
                action(AfkPRList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Requisition List';
                    Image = Track;
                    RunObject = Page "AfkItemRequisitionList";
                    //ToolTip = 'View or edit detailed information for the boat types';
                }
                action(AfkPostedPRList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Item Requisition List';
                    Image = Track;
                    RunObject = Page "AfkPostedItemRequisitionList";
                    //ToolTip = 'View or edit detailed information for the boat types';
                }
                action(AfkFicheSuiveuse)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Requisition Follow Up';
                    Image = Report;
                    RunObject = Report "AfkPurchaseFollowUp";
                    //ToolTip = 'View or edit detailed information for the boat types';
                }
            }
        }
    }


}