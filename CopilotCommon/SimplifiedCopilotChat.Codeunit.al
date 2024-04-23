namespace DylanBinaryStream.CopilotCommon;

using System.AI;

codeunit 77001 "Simplified Copilot Chat"
{
    Access = Internal;

    procedure GetAIResponse(SystemPrompt: Text; UserPrompt: Text; Capability: Enum "Copilot Capability"): Text
    var
        AzureOpenAI: Codeunit "Azure OpenAI";
        AOAIOperationResponse: Codeunit "AOAI Operation Response";
        AOAIChatCompletionParams: Codeunit "AOAI Chat Completion Params";
        AOAIChatMessages: Codeunit "AOAI Chat Messages";
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        Result: Text;
        EntityTextModuleInfo: ModuleInfo;
    begin
        AzureOpenAI.SetAuthorization(Enum::"AOAI Model Type"::"Chat Completions", IsolatedStorageWrapper.GetEndpoint(),
            IsolatedStorageWrapper.GetDeployment(), IsolatedStorageWrapper.GetSecretKey());
        AzureOpenAI.SetCopilotCapability(Capability);

        AOAIChatCompletionParams.SetMaxTokens(1000);
        AOAIChatCompletionParams.SetTemperature(0);

        AOAIChatMessages.AddSystemMessage(SystemPrompt);
        AOAIChatMessages.AddUserMessage(UserPrompt);

        AzureOpenAI.GenerateChatCompletion(AOAIChatMessages, AOAIChatCompletionParams, AOAIOperationResponse);

        if AOAIOperationResponse.IsSuccess() then
            Result := AOAIChatMessages.GetLastMessage()
        else
            Error(AOAIOperationResponse.GetError());

        exit(Result);
    end;
}
