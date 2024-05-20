enum 50124 "Excel Save Type" implements "Excel Save"
{
    Extensible = true;

    value(0; Download)
    {
        Caption = 'Download';
        Implementation = "Excel Save" = "Download Excel Save";
    }
    value(1; "Save To Stream")
    {
        Caption = 'Save To Stream';
        Implementation = "Excel Save" = "Save To Stream Excel Save";
    }
}