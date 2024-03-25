tableextension 50130 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50130; "Grade Nos."; Code[20])
        {
            Caption = 'Grade Nos.';
            TableRelation = "No. Series";
        }
    }
}