tableextension 50131 "Customer Ext" extends Customer
{
    fields
    {
        field(50130; "Grade No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade No.';
            TableRelation = Grade;
            NotBlank = true;

            trigger OnValidate()
            begin
                CalcFields("Grade Description");
                OnAfterValidate(Rec);
            end;
        }
        field(50131; "Grade Description"; Text[100])
        {
            Caption = 'Grade Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Grade.Description where("No." = field("Grade No.")));
            Editable = false;
        }
    }

    [IntegrationEvent(true, false)]
    local procedure OnAfterValidate(CustomerRec: Record Customer)
    begin
    end;
}