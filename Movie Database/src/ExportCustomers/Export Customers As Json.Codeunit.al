codeunit 50136 "Export Customers As Json"
{
    trigger OnRun()
    begin
        ExportCustomersToZipArchive();
    end;

    procedure ExportCustomersToZipArchive()
    var
        Customer: Record Customer;
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        ArchiveFilename: Label 'Customer-Archive-%1.zip';
        Filename: Text;
    begin
        Clear(Customer);
        Clear(TempBlob);
        DataCompression.CreateZipArchive();

        if Customer.FindSet() then
            repeat
                CreateCustomerJsonRecFile(Customer, DataCompression);
            until Customer.Next() = 0;

        DataCompression.SaveZipArchive(TempBlob.CreateOutStream());
        Filename := StrSubstNo(ArchiveFilename, CurrentDateTime());
        File.DownloadFromStream(
            TempBlob.CreateInStream(),
            '',
            '',
            '',
            Filename
        );
    end;

    local procedure CreateCustomerJsonRecFile(Customer: Record Customer; var DataCompression: Codeunit "Data Compression")
    var
        TempBlob: Codeunit "Temp Blob";
        CustomerJsonTxt: Text;
        FilePath: Label 'Customer-%1.json';
    begin
        Clear(TempBlob);
        CustomerJsonTxt := ConvertCustomerRecToJsonObj(Customer);
        TempBlob.CreateOutStream().WriteText(CustomerJsonTxt);
        DataCompression.AddEntry(TempBlob.CreateInStream(), StrSubstNo(FilePath, Customer."No."));
    end;

    local procedure ConvertCustomerRecToJsonObj(Customer: Record Customer) TxtResult: Text
    var
        JsonObj: JsonObject;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
    begin
        Clear(JsonObj);

        JsonObj.Add(Customer.FieldCaption("No."), Customer."No.");
        JsonObj.Add(Customer.FieldCaption(Name), Customer.Name);
        JsonObj.Add(Customer.FieldCaption(Address), Customer.Address);
        JsonObj.Add(Customer.FieldCaption("Post Code"), Customer."Post Code");
        JsonObj.Add(Customer.FieldCaption(City), Customer.City);
        JsonObj.Add(Customer.FieldCaption("Country/Region Code"), Customer."Country/Region Code");
        JsonObj.Add(Customer.FieldCaption("Phone No."), Customer."Phone No.");
        JsonObj.Add(Customer.FieldCaption("E-Mail"), Customer."E-Mail");
        JsonObj.Add(Customer.FieldCaption("Home Page"), Customer."Home Page");
        JsonObj.Add(Customer.FieldCaption("VAT Registration No."), Customer."VAT Registration No.");
        JsonObj.Add(Customer.FieldCaption("Currency Code"), Customer."Currency Code");
        JsonObj.Add(Customer.FieldCaption("Payment Terms Code"), Customer."Payment Terms Code");
        JsonObj.Add(Customer.FieldCaption("Payment Method Code"), Customer."Payment Method Code");
        JsonObj.Add(Customer.FieldCaption(Blocked), Customer.Blocked);

        Customer.Image.ExportStream(TempBlob.CreateOutStream());
        JsonObj.Add(Customer.FieldCaption(Image), Base64Convert.ToBase64(TempBlob.CreateInStream()));

        JsonObj.WriteTo(TxtResult);
    end;
}