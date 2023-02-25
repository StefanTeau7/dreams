const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "dreamcatcher": {
                    "endpointType": "GraphQL",
                    "region": "us-west-1",
                    "authorizationType": "API_KEY"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "Region": "us-west-1",
                        "AuthMode": "API_KEY",
                        "ClientDatabasePrefix": "dreamcatcher_API_KEY"
                    }
                }
            }
        }
    }
}''';