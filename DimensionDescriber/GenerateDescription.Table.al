namespace DylanBinaryStream.DimensionDescriber;

table 77100 "Generate Description"
{
    Caption = 'Generate Description';
    TableType = Temporary;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = false;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(3; "Code Caption"; Text[80])
        {
            Caption = 'Code Caption';
            Editable = false;
        }
        field(4; "Filter Caption"; Text[80])
        {
            Caption = 'Filter Caption';
            Editable = false;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}
