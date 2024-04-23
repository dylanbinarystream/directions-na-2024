namespace DylanBinaryStream.CopilotCommon;

page 77000 "Secret Setup"
{
    Caption = 'Copilot Secret Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Endpoint; Endpoint)
                {
                    ApplicationArea = All;
                    Caption = 'Endpoint';
                    NotBlank = true;
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetEndpoint(Endpoint);
                    end;
                }

                field(SecretKey; SecretKey)
                {
                    ApplicationArea = All;
                    Caption = 'Secret Key';
                    NotBlank = true;
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetSecretKey(SecretKey);
                    end;
                }

                field(Deployment; Deployment)
                {
                    ApplicationArea = All;
                    Caption = 'Deployment';
                    NotBlank = true;
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                    trigger OnValidate()
                    begin
                        IsolatedStorageWrapper.SetDeployment(Deployment);
                    end;
                }
            }
        }
    }

    var
        IsolatedStorageWrapper: Codeunit "Isolated Storage Wrapper";
        Endpoint: Text;
        SecretKey: Text;
        Deployment: Text;
}
