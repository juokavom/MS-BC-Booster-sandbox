page 50133 "Json Placeholder Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Json Placeholder Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(UserId; UserId)
                {
                    ApplicationArea = All;
                    Caption = 'User Id';
                }
                field(JsonResult; JsonResult)
                {
                    ApplicationArea = All;
                    Caption = 'Json Result';
                    MultiLine = true;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetDetails)
            {
                ApplicationArea = All;
                Caption = 'Get Details';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    GetDetailsFromAPI();
                end;
            }
        }
    }

    var
        UserId: Integer;
        JsonResult: Text;


    local procedure GetDetailsFromAPI()
    var
        client: HttpClient;
        headers: HttpHeaders;
        responseMessage: HttpResponseMessage;
    begin
        client.SetBaseAddress('https://jsonplaceholder.typicode.com/users/');
        if not client.Get(Format(UserId), responseMessage) then
            Error('Error while making request to the server.');
        if not responseMessage.IsSuccessStatusCode() then begin
            Error(StrSubstNo('Status Code - %1. Reason - %2', Format(responseMessage.HttpStatusCode), responseMessage.ReasonPhrase()));
        end;
        responseMessage.Content().ReadAs(JsonResult);
    end;
}