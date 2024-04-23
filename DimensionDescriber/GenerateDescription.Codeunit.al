namespace DylanBinaryStream.DimensionDescriber;

using System.AI;
using DylanBinaryStream.CopilotCommon;

codeunit 77101 "Generate Description"
{
    Access = Internal;

    procedure SetInput(TempDescriptionInput: Record "Generate Description" temporary)
    begin
        TempDescription.Reset();
        TempDescription.DeleteAll();
        TempDescription.Copy(TempDescriptionInput, true);
    end;

    procedure GetResponse() Response: Text[100];
    var
        SimplifiedCopilotChat: Codeunit "Simplified Copilot Chat";
    begin
        Response := CopyStr(SimplifiedCopilotChat.GetAIResponse(GetSystemPrompt(), GetUserPrompt(), Enum::"Copilot Capability"::"Dimension Describer"), 1, 100);
    end;

    local procedure GetSystemPrompt() SystemPrompt: Text
    begin
        SystemPrompt := 'Your task is to generate the description field for a financial dimension given the context of the dimension code and name. ' +
            'You should output only your suggested dimension description. ' +
            'The dimension description field has a max character length of 100 characters.\n\n' +
            'Example input:\n' +
            'Dimension code: COMPANY\n' +
            'Dimension name: Company\n\n' +
            'Example output:\n' +
            'Describes the company or subsidiary that finanical information is associated with.';
    end;

    local procedure GetUserPrompt() UserPrompt: Text
    begin
        UserPrompt :=
            'Please use the following context to generate a dimension description:\n' +
            'Dimension code: ' + TempDescription.Code + '\n' +
            'Dimension name: ' + TempDescription.Name;
    end;

    var
        TempDescription: Record "Generate Description" temporary;
}
