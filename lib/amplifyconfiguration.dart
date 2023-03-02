const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "dreamcatcher": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://eddyjenwxfc7rjtqb22qbf3eaa.appsync-api.us-west-1.amazonaws.com/graphql",
                    "region": "us-west-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-jtu6g2qcjzgglbhqedb3gtfkny"
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
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "891bebd8446747b0acca80299c7b2dbd",
                        "Region": "us-west-2"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-west-2"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://eddyjenwxfc7rjtqb22qbf3eaa.appsync-api.us-west-1.amazonaws.com/graphql",
                        "Region": "us-west-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-jtu6g2qcjzgglbhqedb3gtfkny",
                        "ClientDatabasePrefix": "dreamcatcher_API_KEY"
                    },
                    "dreamcatcher_AWS_IAM": {
                        "ApiUrl": "https://eddyjenwxfc7rjtqb22qbf3eaa.appsync-api.us-west-1.amazonaws.com/graphql",
                        "Region": "us-west-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "dreamcatcher_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-west-1:a5f2bd5d-91f5-4974-9ac3-358701b4fcec",
                            "Region": "us-west-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-west-1_qqvHKM0TB",
                        "AppClientId": "8n499tslb10q04jmo3qrni5j9",
                        "Region": "us-west-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": [
                                "REQUIRES_LOWERCASE",
                                "REQUIRES_NUMBERS",
                                "REQUIRES_SYMBOLS",
                                "REQUIRES_UPPERCASE"
                            ]
                        },
                        "signupAttributes": [],
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "dreamcatcher-storage-e009c136113350-dev",
                        "Region": "us-west-1"
                    }
                }
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "891bebd8446747b0acca80299c7b2dbd",
                    "region": "us-west-2"
                },
                "pinpointTargeting": {
                    "region": "us-west-2"
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "dreamcatcher-storage-e009c136113350-dev",
                "region": "us-west-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';