namespace DylanBinaryStream.CopilotCommon;

codeunit 77000 "Isolated Storage Wrapper"
{
    SingleInstance = true;
    Access = Internal;

    var
        IsolatedStorageSecretKeyKey: Label 'AOAISecret', Locked = true;
        IsolatedStorageDeploymentKey: Label 'AOAIDeployment', Locked = true;
        IsolatedStorageEndpointKey: Label 'AOAIEndpoint', Locked = true;
        MissingSecretErr: Label '%1 is not specified. Please set it in the Copilot Secret Setup page.',
            Locked = true, Comment = '%1 - missing secret';

    procedure SetSecretKey(SecretKey: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageSecretKeyKey, SecretKey);
    end;

    procedure GetSecretKey() SecretKey: Text
    begin
        if not IsolatedStorage.Get(IsolatedStorageSecretKeyKey, SecretKey) then
            Error(MissingSecretErr, 'Secret Key');
    end;

    procedure SetDeployment(Deployment: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageDeploymentKey, Deployment);
    end;

    procedure GetDeployment() Deployment: Text
    begin
        if not IsolatedStorage.Get(IsolatedStorageDeploymentKey, Deployment) then
            Error(MissingSecretErr, 'Deployment');
    end;

    procedure SetEndpoint(Endpoint: Text)
    begin
        IsolatedStorage.Set(IsolatedStorageEndpointKey, Endpoint);
    end;

    procedure GetEndpoint() Endpoint: Text
    begin
        if not IsolatedStorage.Get(IsolatedStorageEndpointKey, Endpoint) then
            Error(MissingSecretErr, 'Endpoint');
    end;
}
