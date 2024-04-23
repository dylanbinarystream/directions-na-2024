namespace DylanBinaryStream.DimensionDescriber;

using Microsoft.Finance.Dimension;

page 77100 "Generate Description"
{
    PageType = PromptDialog;
    InherentEntitlements = X;
    InherentPermissions = X;
    Extensible = false;
    Caption = 'Generate a dimension description with Copilot';
    DataCaptionExpression = StrSubstNo(DataCaptionLbl, Rec.Code);
    IsPreview = true;
    SourceTable = "Generate Description";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }
    actions
    {
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
            }
            systemaction(OK)
            {
                Caption = 'Keep it';
                ToolTip = 'Save the description proposed by Copilot.';
            }
            systemaction(Cancel)
            {
                Caption = 'Discard it';
                ToolTip = 'Discard the description proposed by Copilot.';
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Regenerate the description proposed by Copilot.';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        RunGeneration();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        SaveDescription: Codeunit "Save Description";
    begin
        if CloseAction = CloseAction::OK then
            SaveDescription.Save(Rec);
    end;

    procedure SetInput(Dimension: Record Dimension)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        Rec.TransferFields(Dimension);
    end;

    local procedure RunGeneration()
    var
        GenerateDescription: Codeunit "Generate Description";
        Result: Text[100];
    begin
        CurrPage.PromptMode := PromptMode::Generate;
        GenerateDescription.SetInput(Rec);

        Result := GenerateDescription.GetResponse();
        Rec.Description := Result;
        CurrPage.Update();
    end;

    var
        DataCaptionLbl: Label 'Description proposal for %1', Locked = true, Comment = '%1 - Dimension code';
}
