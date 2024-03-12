codeunit 55101 "Armstrong Numbers"
{
    procedure ShowError(message: Text)
    var
        MyErrorInfo: ErrorInfo;
    begin
        MyErrorInfo.Title('Error when validating entries');
        MyErrorInfo.Message(message);
        Error(MyErrorInfo);
    end;

    procedure ValidateEntries(StartNumber: Integer; EndNumber: Integer)
    begin
        if (StartNumber <= 0) or (EndNumber <= 0) then ShowError('Numbers must be greater than 0');
        if StartNumber > EndNumber then ShowError('Start number must be lower than end');
    end;

    procedure EvaluateArmstrongNumber(number: Integer): Boolean
    var
        left, current, last, sum : Integer;
    begin
        left := number;
        last := number MOD 10;
        sum := 0;

        while left > 0 do begin
            current := left MOD 10;
            sum := sum + Power(current, last);
            left := left DIV 10;
        end;

        exit(sum = number);
    end;

    procedure PerformCalculations(StartNumber: Integer; EndNumber: Integer)
    var
        Dialog: Dialog;
        Progress: Decimal;
        i: Integer;
        isArmstrong: Boolean;
        SelectedArmstrongNumbers: Text;
    begin
        ValidateEntries(StartNumber, EndNumber);

        Progress := 0;
        Dialog.Open('Looking for Armstrong numbers in range #1 to #2\Progress: #3%', StartNumber, EndNumber, Progress);

        for i := StartNumber to EndNumber do begin
            Progress := i * 100 / EndNumber;
            Dialog.Update();
            isArmstrong := false;
            isArmstrong := EvaluateArmstrongNumber(i);
            if isArmstrong then SelectedArmstrongNumbers := SelectedArmstrongNumbers + Format(i) + ', ';
            // Sleep(1000);
        end;

        Dialog.Close();
        Message('Armstrong numbers in range %1 to %2 is: %3', StartNumber, EndNumber, SelectedArmstrongNumbers);
    end;
}