namespace DylanBinaryStream.HelloWorld;

using System.AI;

codeunit 77002 "Hello World Setup"
{
    Subtype = Install;
    Access = Internal;

    trigger OnInstallAppPerDatabase()
    begin
        RegisterCapability();
    end;

    local procedure RegisterCapability()
    var
        CopilotCapability: Codeunit "Copilot Capability";
        LearnMoreUrlTxt: Label 'https://example.com/CopilotToolkit', Locked = true;
    begin
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Hello World") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Hello World", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);
    end;
}
