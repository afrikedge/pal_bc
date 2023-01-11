table 50012 AfkSecurityItem
{
    Caption = 'SecurityItem';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Account Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = BankAccount;
            OptionCaption = 'BankAccount';
            DataClassification = CustomerContent;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
        field(3; "Account Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = IF ("Account Type" = CONST("BankAccount")) "Bank Account"
            // ELSE
            // IF ("Account Type" = CONST(Customer)) Customer
            // ELSE
            // IF ("Account Type" = CONST(Vendor)) Vendor
            // ELSE
            // IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            // ELSE
            // IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            // ELSE
            // IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            // ELSE
            // IF ("Account Type" = CONST(Employee)) Employee
            ;

        }

    }
    keys
    {
        key(PK; "Account Type", "User ID", "Account Code")
        {
            Clustered = true;
        }
    }
}
