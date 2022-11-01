report 50006 AfkWhseDelivery
{
    ApplicationArea = All;
    Caption = 'Delivery';
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './src/requisition/reports/layouts/AfkWhseDelivery.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(AfkWhseDelivery; AfkWhseDelivery)
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Delivery';

            column(ShortcutDimension1Code_AfkWhseDelivery; "Shortcut Dimension 1 Code")
            {
            }
            column(No_AfkWhseDelivery; "No.")
            {
            }
            column(PostingDate_AfkWhseDelivery; "Posting Date")
            {
            }
            column(LocationCode_AfkWhseDelivery; "Location Code")
            {
            }
            column(ExternalDocNo_AfkWhseDelivery; "External Doc No")
            {
            }
            column(Description_AfkWhseDelivery; Description)
            {
            }


            column(AfkLigneDesignationLbl; AfkLigneDesignationLbl)
            {
            }
            column(AfkLigneNoLbl; AfkLigneNoLbl)
            {
            }
            column(AfkLigneReferenceLbl; AfkLigneReferenceLbl)
            {
            }
            column(AfkLigneQteLbl; AfkLigneQteLbl)
            {
            }
            column(AfkLigneUniteLbl; AfkLigneUniteLbl)
            {
            }
            column(AfkNatureBudgetaireLbl; AfkNatureBudgetaireLbl)
            {
            }
            column(AfkNumDALbl; AfkNumDALbl)
            {
            }
            column(AfkObjectLbl; AfkObjectLbl)
            {
            }
            column(AfkTacheBudgetaireLbl; AfkTacheBudgetaireLbl)
            {
            }
            column(AfkNumCommande; AfkNumCommande)
            {
            }
            column(AfkCompanyPicture; CompanyInformation.Picture)
            {
            }


            dataitem("AfkWhseDeliveryLine"; AfkWhseDeliveryLine)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "AfkWhseDelivery";
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(AfkNumLigneText; AfkNumLigneText)//************
                {
                }
                column(No_AfkWhseDeliveryLine; "No.")
                {
                }
                column(Description_AfkWhseDeliveryLine; Description)
                {
                }
                column(Quantity_AfkWhseDeliveryLine; Quantity)
                {
                }
                column(UnitCost_AfkWhseDeliveryLine; "Unit Cost")
                {
                }
                column(UnitofMeasureCode_AfkWhseDeliveryLine; "Unit of Measure Code")
                {
                }

                trigger OnPreDataItem()
                begin

                end;

                trigger OnAfterGetRecord()
                begin
                    AfkNumLigne := AfkNumLigne + 1;
                    if (AfkNumLigne > 9) then
                        AfkNumLigneText := Format(AfkNumLigne)
                    else
                        AfkNumLigneText := '0' + Format(AfkNumLigne);
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

            end;

            trigger OnAfterGetRecord()
            begin
                AfkNumCommande := StrSubstNo(AfkNumCommandeLbl, AfkWhseDelivery."No.");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInformation: Record "Company Information";
        AfkNumLigneText: Code[2];
        AfkNumLigne: Integer;

        AfkAcheteurLbl: Label 'Purchaser :';
        AfkEmetteurLbl: Label 'Issuer :';
        AfkLigneDesignationLbl: Label 'Description';
        AfkLigneNoLbl: Label 'No';
        AfkLignePULbl: Label 'Unit price';
        AfkLigneQteLbl: Label 'Qty';
        AfkLigneReferenceLbl: Label 'Reference';
        AfkLigneUniteLbl: Label 'Unit';
        AfkLimbeLeLbl: Label 'Limbe on _____________________';
        AfkNatureBudgetaireLbl: Label 'Nature Code :';
        AfkNumCommandeLbl: Label 'DELIVERY ORDER %1';
        AfkNumDALbl: Label 'Requisition No';
        AfkObjectLbl: Label 'Object :';
        AfkTacheBudgetaireLbl: Label 'Task Code :';
        PurchaserText: Text[30];
        AfkNumCommande: Text[50];

}
