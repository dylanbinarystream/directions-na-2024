namespace DylanBinaryStream.DimensionCreator;

using Microsoft.Finance.Dimension;

codeunit 77202 "Save Dimension"
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;
    procedure Save(CreateDim: Record "Create Dimension"; var CreateDimVal: Record "Create Dimension Value")
    var
        Dimension: Record "Dimension";
        DimensionValue: Record "Dimension Value";
    begin
        if not Dimension.Get(CreateDim.Code) then begin
            Dimension.Init();
            Dimension.TransferFields(CreateDim);
            Dimension.Insert();

            CreateDimVal.Reset();
            if CreateDimVal.FindSet() then
                repeat
                    DimensionValue.Init();
                    DimensionValue.TransferFields(CreateDimVal);
                    DimensionValue."Dimension Code" := CreateDim.Code;
                    DimensionValue.Insert();
                until CreateDimVal.Next() = 0;
        end;
    end;
}
