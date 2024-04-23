namespace DylanBinaryStream.DimensionCreator;

page 77200 "Create Dimension"
{
    PageType = PromptDialog;
    Extensible = false;
    Caption = 'Create a new dimension using Copilot';
    DataCaptionExpression = InputUserPrompt;
    IsPreview = true;
    SourceTable = "Create Dimension";
    SourceTableTemporary = true;

    layout
    {
        area(Prompt)
        {
            field(InputUserPrompt; InputUserPrompt)
            {
                ApplicationArea = All;
                ShowCaption = false;
                MultiLine = true;
                InstructionalText = 'Describe a Dimension you want to create with Copilot.';

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
        }
        area(Content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                Editable = true;
            }
            field(CodeCaption; Rec."Code Caption")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field(FilterCaption; Rec."Filter Caption")
            {
                ApplicationArea = All;
                Editable = true;
            }
            part(Values; "Create Dimension Subpart")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field(DebugJSON; DebugJSON)
            {
                ApplicationArea = All;
                Visible = false;
                Editable = true;
                MultiLine = true;
            }
        }
    }
    actions
    {
        area(PromptGuide)
        {
            action(CreateDimension)
            {
                ApplicationArea = All;
                Caption = 'Create a dimension named [name] with values [values]';

                trigger OnAction()
                begin
                    InputUserPrompt := 'Create a dimension named [name] with values [values]';
                end;
            }
        }
        area(SystemActions)
        {
            systemaction(Generate)
            {
                Caption = 'Generate';
                ToolTip = 'Generate a Dimension proposed by Copilot.';
                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
            systemaction(OK)
            {
                Caption = 'Keep it';
                ToolTip = 'Save the Dimension proposed by Copilot.';
            }
            systemaction(Cancel)
            {
                Caption = 'Discard it';
                ToolTip = 'Discard the Dimension proposed by Copilot.';
            }
            systemaction(Regenerate)
            {
                Caption = 'Regenerate';
                ToolTip = 'Regenerate the Dimension proposed by Copilot.';

                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        SaveDimension: Codeunit "Save Dimension";
        CreateDimVal: Record "Create Dimension Value" temporary;

    begin
        if CloseAction = CloseAction::OK then begin
            CurrPage.Values.Page.GetRec(CreateDimVal);
            SaveDimension.Save(Rec, CreateDimVal);
        end;
    end;

    local procedure RunGeneration()
    var
        CreateDimension: Codeunit "Create Dimension";
        CreateDimensionRes: Record "Create Dimension" temporary;
        CreateDimensionVal: Record "Create Dimension Value" temporary;
        Retries: Integer;
        Response: Text;
    begin
        CreateDimension.SetUserPrompt(InputUserPrompt);

        Retries := 5;
        Response := CreateDimension.GetResponse();
        ParseResponseWithRetries(CreateDimension, CreateDimensionRes, CreateDimensionVal, Response, Retries);

        Rec.Reset();
        Rec.DeleteAll();
        Rec.Copy(CreateDimensionRes);

        CurrPage.Values.Page.Load(CreateDimensionVal);
        DebugJSON := Response; // For debugging
        CurrPage.Update();
    end;

    local procedure ParseResponseWithRetries(CreateDimension: Codeunit "Create Dimension";
        var CreateDimensionRes: Record "Create Dimension" temporary;
        var CreateDimensionVal: Record "Create Dimension Value"; Response: Text; Retries: Integer)
    var
        i: Integer;
    begin
        while not CreateDimension.ParseResponse(Response, CreateDimensionRes, CreateDimensionVal) do begin
            i := i + 1;
            if i > Retries then
                Error('Invalid response from Copilot. Please try a different prompt.')
            else
                Response := CreateDimension.GetResponse();
        end;
    end;

    var
        InputUserPrompt: Text;
        DebugJSON: Text;
}
