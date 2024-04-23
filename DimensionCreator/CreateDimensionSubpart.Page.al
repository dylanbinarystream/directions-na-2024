namespace DylanBinaryStream.DimensionCreator;

page 77201 "Create Dimension Subpart"
{
    PageType = ListPart;
    Extensible = false;
    ApplicationArea = All;
    Caption = 'Create Dimension Subpart';
    SourceTable = "Create Dimension Value";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Values)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    procedure Load(var CreateDimensionValue: Record "Create Dimension Value" temporary)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        CreateDimensionValue.Reset();
        if CreateDimensionValue.FindSet() then
            repeat
                Rec.TransferFields(CreateDimensionValue);
                Rec.Insert();
            until CreateDimensionValue.Next() = 0;
        CurrPage.Update();
    end;

    procedure GetRec(var CreateDimensionValue: Record "Create Dimension Value" temporary)
    begin
        Rec.Reset();
        if Rec.FindSet() then
            repeat
                CreateDimensionValue.TransferFields(Rec);
                CreateDimensionValue.Insert();
            until Rec.Next() = 0;
    end;
}
