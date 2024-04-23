namespace DylanBinaryStream.HelloWorld;

using Microsoft.Sales.Customer;
using System.AI;
using DylanBinaryStream.CopilotCommon;

pageextension 77000 HelloWorld extends "Customer List"
{
    trigger OnOpenPage();
    var
        SimplifiedCopilotChat: Codeunit "Simplified Copilot Chat";
    begin
        Message(SimplifiedCopilotChat.GetAIResponse('', 'Return Hello World reversed do not add any additional description or text', Enum::"Copilot Capability"::"Hello World"));
    end;
}
