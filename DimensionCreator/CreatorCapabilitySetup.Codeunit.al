namespace DylanBinaryStream.DimensionCreator;

using System.AI;

codeunit 77200 "Creator Capability Setup"
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
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Dimension Creator") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Dimension Creator", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);
    end;
}
