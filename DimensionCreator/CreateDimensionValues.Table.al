namespace DylanBinaryStream.DimensionCreator;

table 77201 "Create Dimension Value"
{
    Caption = 'Create Dimension Value';
    TableType = Temporary;

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Code")
        {
            Clustered = true;
        }
    }
}
