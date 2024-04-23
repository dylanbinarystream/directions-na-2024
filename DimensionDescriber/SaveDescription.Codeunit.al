namespace DylanBinaryStream.DimensionDescriber;

using Microsoft.Finance.Dimension;

codeunit 77102 "Save Description"
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;
    procedure Save(TempDescription: Record "Generate Description")
    var
        Dimension: Record "Dimension";
    begin
        Dimension.Get(TempDescription."Code");
        Dimension.Description := TempDescription.Description;
        Dimension.Modify();
    end;
}
