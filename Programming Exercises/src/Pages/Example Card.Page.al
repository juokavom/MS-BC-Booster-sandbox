page 55109 "Example Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Example;
    Caption = 'Example Card';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field("Field One"; Rec."Field One")
                {
                    ToolTip = 'Specifies the value of the Field One field.';

                    trigger OnAfterLookup(Selected: RecordRef)
                    begin
                        InsertLog('OnAfterLookup Field One');
                    end;

                    trigger OnAssistEdit()
                    begin
                        InsertLog('OnAssistEdit Field One');
                    end;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        InsertLog('OnControlAddIn Field One');
                    end;

                    trigger OnDrillDown()
                    begin
                        InsertLog('OnDrillDown Field One');
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        InsertLog('OnLookup Field One');
                    end;

                    trigger OnValidate()
                    begin
                        InsertLog('OnValidate Field One');
                    end;
                }
                field("Field Two"; Rec."Field Two")
                {
                    ToolTip = 'Specifies the value of the Field Two field.';

                    trigger OnAfterLookup(Selected: RecordRef)
                    begin
                        InsertLog('OnAfterLookup Field Two');
                    end;

                    trigger OnAssistEdit()
                    begin
                        InsertLog('OnAssistEdit Field Two');
                    end;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        InsertLog('OnControlAddIn Field Two');
                    end;

                    trigger OnDrillDown()
                    begin
                        InsertLog('OnDrillDown Field Two');
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        InsertLog('OnLookup Field Two');
                    end;

                    trigger OnValidate()
                    begin
                        InsertLog('OnValidate Field Two');
                    end;
                }
            }
        }
    }

    local procedure InsertLog(TriggerName: Text[100])
    var
        TriggerLogRec: Record "Trigger Log";
    begin
        TriggerLogRec.InsertLogEntry('Example Card', TriggerName);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        InsertLog('OnAfterGetCurrRecord');
    end;

    trigger OnAfterGetRecord()
    begin
        InsertLog('OnAfterGetRecord');
    end;

    trigger OnClosePage()
    begin
        InsertLog('OnClosePage');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        InsertLog('OnDeleteRecord');
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        InsertLog('OnFindRecord');
    end;

    trigger OnInit()
    begin
        InsertLog('OnInit');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InsertLog('OnInsertRecord');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        InsertLog('OnModifyRecord');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InsertLog('OnNewRecord');
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        InsertLog('OnNextRecord');
    end;

    trigger OnOpenPage()
    begin
        InsertLog('OnOpenPage');
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        InsertLog('OnPageBackgroundTaskCompleted');
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    begin
        InsertLog('OnPageBackgroundTaskError');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        InsertLog('OnQueryClosePage');
    end;
}