namespace DylanBinaryStream.DimensionDescriber;

using System.AI;

codeunit 77100 "Describer Capability Setup"
{
    Subtype = Install;
    InherentEntitlements = X;
    InherentPermissions = X;
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
        if not CopilotCapability.IsCapabilityRegistered(Enum::"Copilot Capability"::"Dimension Describer") then
            CopilotCapability.RegisterCapability(Enum::"Copilot Capability"::"Dimension Describer", Enum::"Copilot Availability"::Preview, LearnMoreUrlTxt);
    end;
}
