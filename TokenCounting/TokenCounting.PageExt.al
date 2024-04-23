namespace DylanBinaryStream.TokenCounting;

using Microsoft.Purchases.Vendor;
using System.AI;

pageextension 77300 TokenCounting extends "Vendor List"
{
    trigger OnOpenPage();
    var
        AOAIToken: Codeunit "AOAI Token";
        Prompt: Text;
        SecretPrompt: SecretText;
    begin
        Prompt := 'Return Hello World reversed';
        SecretPrompt := Prompt;
        Message(StrSubstNo('Token Count: %1', AOAIToken.GetGPT35TokenCount(Prompt)));
    end;
}
