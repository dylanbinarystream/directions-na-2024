namespace DylanBinaryStream.DimensionDescriber;

using Microsoft.Finance.Dimension;

pageextension 77100 "Dimensions Describer" extends "Dimensions"
{
    actions
    {
        addlast(Prompting)
        {
            action(GenerateDescriptionAction)
            {
                Caption = 'Generate Description';
                Image = Sparkle;
                ApplicationArea = All;
                ToolTip = 'Generate a dimension description using Copilot.';

                trigger OnAction()
                var
                    GenerateDescription: Page "Generate Description";
                begin
                    GenerateDescription.SetInput(Rec);
                    GenerateDescription.RunModal();
                end;
            }
        }
    }
}
