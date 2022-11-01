pageextension 50018 AfkPurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = false;
            Editable = false;
        }
        modify(FilteredTypeField)
        {
            Visible = false;
            Editable = false;
        }
        modify("No.")
        {
            Editable = DocIsEditable;
        }
        modify(Quantity)
        {
            Editable = DocIsEditable;
        }

        modify("Direct Unit Cost")
        {
            Editable = DocIsEditable;
        }
        modify("Line Amount")
        {
            Editable = DocIsEditable;
        }
        modify("Unit of Measure Code")
        {
            Editable = DocIsEditable;
        }
        modify("Line Discount %")
        {
            Editable = DocIsEditable;
        }
        modify("Line Discount Amount")
        {
            Editable = DocIsEditable;
        }
        modify("Unit Cost (LCY)")
        {
            Editable = DocIsEditable;
        }
    }

    trigger OnAfterGetRecord()
    var
        Header: Record "Purchase Header";
        isRelease: Boolean;
    begin
        Header.get(Rec."Document Type"::Order, Rec."Document No.");
        isRelease := Header.Status = Header.Status::Released;
        DocIsEditable := (Header.Afk_CommitmentType <> Header.Afk_CommitmentType::"Purchase order");

    end;


    var
        DocIsEditable: Boolean;
}
