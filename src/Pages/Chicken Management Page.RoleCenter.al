page 50125 "Chicken Management Rolecenter"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(HeadLineOrderProcessor; "Headline RC Order Processor")
            {
                ApplicationArea = All;
            }
            part(O365CustomerActivity; "O365 Customer Activity Page")
            {
                ApplicationArea = All;
            }
            part(O365Activities; "O365 Activities")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(MasterData)
            {
                Caption = 'Master Data';
                Image = RegisteredDocs;
                action(ChickenList)
                {
                    Caption = 'Chicken List';
                    ApplicationArea = All;
                    RunObject = page "Chicken List";
                }
                action(ChickenTypes)
                {
                    Caption = 'Chicken Types';
                    ApplicationArea = All;
                    RunObject = page "Chicken Types";
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = List;
                action(EggProduction)
                {
                    Caption = 'Egg Production List';
                    ApplicationArea = All;
                    RunObject = page "Egg Production List";
                }
                action(EggTypes)
                {
                    Caption = 'Egg Types';
                    ApplicationArea = All;
                    RunObject = page "Egg Types";
                }

            }
        }

        area(Embedding)
        {
            action(eChickenList)
            {
                ApplicationArea = All;
                Caption = 'Chicken List';
                RunObject = page "Chicken List";
            }
            action(eChickenTypes)
            {
                ApplicationArea = All;
                Caption = 'Chicken Types';
                RunObject = page "Chicken Types";
            }
            action(eEggProduction)
            {
                ApplicationArea = All;
                Caption = 'Egg Production List';
                RunObject = page "Egg Production List";
            }
            action(eEggTypes)
            {
                ApplicationArea = All;
                Caption = 'Egg Types';
                RunObject = page "Egg Types";
            }
        }
    }
}