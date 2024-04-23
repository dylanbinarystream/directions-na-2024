namespace DylanBinaryStream.DimensionCreator;

using Microsoft.Finance.Dimension;

pageextension 77200 "Dimensions Creator" extends "Dimensions"
{
    actions
    {
        addfirst(Category_New)
        {
            actionref(CreateDimensionPromoted; CreateDimensionAction)
            {
            }
        }

        addfirst(Prompting)
        {
            action(CreateDimensionAction)
            {
                Caption = 'Create with Copilot';
                Image = Sparkle;
                ApplicationArea = All;
                ToolTip = 'Create a new dimensions using Copilot.';

                trigger OnAction()
                var
                    CreateDimension: Page "Create Dimension";
                begin
                    CreateDimension.RunModal();
                end;
            }
        }
    }
}
