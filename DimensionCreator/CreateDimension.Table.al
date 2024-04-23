namespace DylanBinaryStream.DimensionCreator;

table 77200 "Create Dimension"
{
    Caption = 'Create Dimension';
    TableType = Temporary;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            Editable = true;
        }
        field(3; "Code Caption"; Text[80])
        {
            Caption = 'Code Caption';
            Editable = true;
        }
        field(4; "Filter Caption"; Text[80])
        {
            Caption = 'Filter Caption';
            Editable = true;
        }
        field(5; Description; Text[1000])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
            Editable = true;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}
