pageextension 50004 AfkSalesOrderProRC extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group(AddOns)
            {
                Caption = 'Addons';
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
            }
        }

    }


}