namespace DylanBinaryStream.DimensionCreator;

using System.AI;
using DylanBinaryStream.CopilotCommon;

codeunit 77201 "Create Dimension"
{
    Access = Internal;

    procedure SetUserPrompt(UserPromptInput: Text)
    begin
        UserPrompt := UserPromptInput;
    end;

    procedure GetResponse() Response: Text;
    var
        SimplifiedCopilotChat: Codeunit "Simplified Copilot Chat";
    begin
        Response := SimplifiedCopilotChat.GetAIResponse(GetSystemPrompt(), UserPrompt, Enum::"Copilot Capability"::"Dimension Creator");
    end;

    [TryFunction]
    procedure ParseResponse(Response: Text; var CreateDimensionRes: Record "Create Dimension" temporary;
        var CreateDimensionVal: Record "Create Dimension Value" temporary);
    var
        DimObj: JsonObject;
        ValArr: JsonArray;
        JsonToken: JsonToken;
        i: Integer;
    begin
        DimObj.ReadFrom(Response);

        DimObj.SelectToken('$.dimensions[0].code', JsonToken);
        CreateDimensionRes.Code := JsonToken.AsValue().AsText();

        DimObj.SelectToken('$.dimensions[0].name', JsonToken);
        CreateDimensionRes.Name := JsonToken.AsValue().AsText();

        DimObj.SelectToken('$.dimensions[0].codeCaption', JsonToken);
        CreateDimensionRes."Code Caption" := JsonToken.AsValue().AsText();

        DimObj.SelectToken('$.dimensions[0].filterCaption', JsonToken);
        CreateDimensionRes."Filter Caption" := JsonToken.AsValue().AsText();

        DimObj.SelectToken('$.dimensions[0].values', JsonToken);
        ValArr := JsonToken.AsArray();

        for i := 1 to ValArr.Count() do begin
            DimObj.SelectToken('$.dimensions[0].values[' + Format(i - 1) + '].code', JsonToken);
            CreateDimensionVal."Code" := JsonToken.AsValue().AsText();

            DimObj.SelectToken('$.dimensions[0].values[' + Format(i - 1) + '].name', JsonToken);
            CreateDimensionVal.Name := JsonToken.AsValue().AsText();

            CreateDimensionVal."Dimension Code" := CreateDimensionRes.Code;
            CreateDimensionVal.Insert();
        end;

    end;

    local procedure GetSystemPrompt() Prompt: Text
    var
        NewLine: Char;
    begin
        NewLine := 10;
        Prompt := Prompt + 'Your task is a generate a JSON response that describes a financial dimension record ';
        Prompt := Prompt + 'to be created in Dyanmics 365 Business Central based on a user''s description.' + NewLine;
        Prompt := Prompt + 'The response should fulfill the requirements of the description provided by the user.' + NewLine;
        Prompt := Prompt + 'You should respond only with valid JSON matching the example response format.' + NewLine;
        Prompt := Prompt + 'Example input:' + NewLine;
        Prompt := Prompt + 'Create a dimension named COMPANY with values LA, SD, PHX' + NewLine;
        Prompt := Prompt + 'Example output:' + NewLine;
        Prompt := Prompt + '{dimensions:[{code:''COMPANY'', name:''Company'', codeCaption:''Company Code'', filterCaption:''Company Filter'', values:[{code:LA, name:''Los Angeles''}, {code:SD, name:''San Diego''}, {code:PHX, name:''Phoenix''}]}]}';
    end;

    var
        TempDescription: Record "Create Dimension" temporary;
        UserPrompt: Text;
}
