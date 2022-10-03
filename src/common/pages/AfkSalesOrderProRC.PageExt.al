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
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page AfkBoatTypes;
                    ToolTip = 'View or edit detailed information for the boat types';
                }
                action(AfkItems)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information about services';
                }
                action(AfkCustomers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = CustomerList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information about customers';
                }
                action(AfkBoats)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Boats';
                    Image = Track;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page AfkBoatList;
                    ToolTip = 'View or edit detailed information for the boats';
                }
                action(AfkCalcParameters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculation Parameters';
                    Image = Track;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page AfkCalcParameters;
                    ToolTip = 'View or edit detailed information for the calculation parameters';
                }
                action(AfkPricing)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Port Services pricing';
                    Image = Track;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page AfkSalesInvPricing;
                    ToolTip = 'View or edit detailed information for the pricing of port services';
                }
                action(AfkPSalesInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = SalesInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'View or edit detailed information about sales invoices';
                }
                action(AfkSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page AfkSetupCard;
                    ToolTip = 'View or edit setup parameters';
                }
                action(AfkSalesStandardCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Sales Codes';
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Standard Sales Codes";
                    //ToolTip = 'View or edit setup parameters';
                }
                action(AfkCreateSalesStandardCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Recurring Sales Invoice';
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Process;
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
                // action(AfkPRList)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Purchase Requisition List';
                //     Image = Track;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page AfkPurchRequisitionList;
                //     //ToolTip = 'View or edit detailed information for the boat types';
                // }
                action(AfkDimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Dimensions";
                    ToolTip = 'View or edit detailed information about dimensions';
                }
                action(AfkBudgets)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Budget Names';
                    Image = CostBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Budget Names";
                    ToolTip = 'View or edit detailed information about budgets';
                }
                action(AfkPRDocs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase requests';
                    Image = PurchaseInvoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase quotes";
                    ToolTip = 'View or edit detailed information about purchase requests';
                }
                action(AfkPODocs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase commitments';
                    Image = Purchase;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase order list";
                    ToolTip = 'View or edit detailed information about commitments';
                }
                action(AfkItems2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information about services';
                }
                action(AfkVendors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    Image = CustomerList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information about vendors';
                }
                action(AfkUserSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "User Setup";
                }

            }
        }
    }


}