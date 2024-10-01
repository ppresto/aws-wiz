data "aws_partition" "current" {}

# Create IAM role with inline WizFullPolicy
resource "aws_iam_role_policy" "tf-policy" {
  name = "WizFullPolicy"
  role = aws_iam_role.user-role-tf.id

  policy = jsonencode({
    "Statement" : [
      {
        "Action" : [
          "account:GetContactInformation",
          "acm-pca:GetCertificateAuthorityCertificate",
          "acm:GetCertificate",
          "amplify:GetApp",
          "amplify:GetBackendEnvironment",
          "amplify:ListApps",
          "amplify:ListBackendEnvironments",
          "amplify:ListBranches",
          "amplify:ListDomainAssociations",
          "amplify:ListTagsForResource",
          "amplifybackend:GetBackend",
          "aoss:BatchGetCollection",
          "aoss:GetAccessPolicy",
          "aoss:GetSecurityPolicy",
          "aoss:ListAccessPolicies",
          "aoss:ListCollections",
          "aoss:ListSecurityPolicies",
          "aoss:ListTagsForResource",
          "apigateway:GET",
          "appconfig:GetConfigurationProfile",
          "appconfig:ListApplications",
          "appconfig:ListConfigurationProfiles",
          "appconfig:ListTagsForResource",
          "appflow:DescribeFlow",
          "applicationinsights:ListApplications",
          "applicationinsights:ListTagsForResource",
          "appstream:DescribeFleets",
          "appstream:DescribeStacks",
          "appstream:DescribeUserStackAssociations",
          "appstream:ListAssociatedFleets",
          "appstream:ListTagsForResource",
          "appsync:GetApiAssociation",
          "aps:ListWorkspaces",
          "backup:GetBackupPlan",
          "backup:GetBackupSelection",
          "bedrock:GetAgent",
          "bedrock:GetAgentActionGroup",
          "bedrock:GetDataSource",
          "bedrock:GetKnowledgeBase",
          "bedrock:ListAgentActionGroups",
          "bedrock:ListAgentKnowledgeBases",
          "bedrock:ListAgents",
          "bedrock:ListDataSources",
          "bedrock:ListKnowledgeBases",
          "chatbot:DescribeChimeWebhookConfigurations",
          "chatbot:DescribeSlackChannelConfigurations",
          "chime:GetAccount",
          "clouddirectory:ListTagsForResource",
          "cloudhsm:DescribeClusters",
          "cloudsearch:DescribeAvailabilityOptions",
          "codeconnections:ListConnections",
          "codeconnections:ListHosts",
          "codeconnections:ListTagsForResource",
          "codeguru-reviewer:DescribeRepositoryAssociation",
          "codeguru-reviewer:ListRepositoryAssociations",
          "codepipeline:ListTagsForResource",
          "codestar-notifications:DescribeNotificationRule",
          "codestar-notifications:ListNotificationRules",
          "databrew:DescribeRecipe",
          "databrew:ListRecipes",
          "datazone:GetDomain",
          "datazone:ListDomains",
          "datazone:ListTagsForResource",
          "detective:ListOrganizationAdminAccount",
          "detective:ListTagsForResource",
          "dlm:GetLifecyclePolicies",
          "dlm:GetLifecyclePolicy",
          "docdb-elastic:GetCluster",
          "docdb-elastic:ListTagsForResource",
          "ds:DescribeSettings",
          "ds:DescribeSharedDirectories",
          "ds:DescribeTrusts",
          "ds:ListTagsForResource",
          "dynamodb:GetResourcePolicy",
          #"ec2:GetEbsEncryptionByDefault",
          "ec2:GetInstanceMetadataDefaults",
          "ec2:GetSnapshotBlockPublicAccessState",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "eks:ListTagsForResource",
          "entityresolution:GetIdNamespace",
          "entityresolution:GetMatchingWorkflow",
          "entityresolution:GetSchemaMapping",
          "entityresolution:ListIdNamespaces",
          "entityresolution:ListMatchingWorkflows",
          "entityresolution:ListSchemaMappings",
          "frauddetector:ListTagsForResource",
          "geo:DescribeGeofenceCollection",
          "geo:DescribeKey",
          "geo:DescribeMap",
          "geo:DescribePlaceIndex",
          "geo:DescribeRouteCalculator",
          "geo:DescribeTracker",
          "geo:ListGeofenceCollections",
          "geo:ListKeys",
          "geo:ListPlaceIndexes",
          "geo:ListRouteCalculators",
          "geo:ListTagsForResource",
          "geo:ListTrackers",
          "glue:GetConnection",
          "identitystore:Describe*",
          "identitystore:List*",
          "internetmonitor:GetMonitor",
          "internetmonitor:ListMonitors",
          "kendra:DescribeDataSource",
          "kinesisanalytics:DescribeApplication",
          "kinesisvideo:GetDataEndpoint",
          "lambda:GetFunction",
          "lambda:GetLayerVersion",
          "lightsail:GetRelationalDatabases",
          "lookoutvision:DescribeProject",
          "macie2:GetAutomatedDiscoveryConfiguration",
          "macie2:GetFindings",
          "macie2:GetMacieSession",
          "mediaconvert:GetQueue",
          "mediaconvert:ListQueues",
          "mediaconvert:ListTagsForResource",
          "mediastore:ListTagsForResource",
          "medical-imaging:GetDatastore",
          "medical-imaging:ListDatastores",
          "medical-imaging:ListTagsForResource",
          "memorydb:ListTags",
          "neptune-graph:GetGraph",
          "neptune-graph:ListGraphSnapshots",
          "neptune-graph:ListGraphs",
          "neptune-graph:ListTagsForResource",
          "networkmonitor:GetMonitor",
          "networkmonitor:ListMonitors",
          "payment-cryptography:GetKey",
          "payment-cryptography:ListKeys",
          "payment-cryptography:ListTagsForResource",
          "qbusiness:GetApplication",
          "qbusiness:ListApplications",
          "qbusiness:ListTagsForResource",
          "qldb:DescribeJournalKinesisStream",
          "qldb:ListJournalKinesisStreamsForLedger",
          "qldb:ListTagsForResource",
          "redshift-serverless:GetScheduledAction",
          "redshift-serverless:ListScheduledActions",
          "resiliencehub:DescribeApp",
          "resiliencehub:ListApps",
          "resiliencehub:ListResiliencyPolicies",
          "resiliencehub:ListTagsForResource",
          "resource-groups:GetAccountSettings",
          "resource-groups:GetGroupConfiguration",
          "resource-groups:GetGroupQuery",
          "resource-groups:GetTags",
          "resource-groups:ListGroups",
          #"s3:GetIntelligentTieringConfiguration",
          #"s3express:GetBucketPolicy",
          #"s3express:ListAllMyDirectoryBuckets",
          "scheduler:GetSchedule",
          "scheduler:ListSchedules",
          "scheduler:ListTagsForResource",
          "serverlessrepo:GetApplication",
          "servicecatalog:DescribePortfolio",
          "servicecatalog:DescribeProductAsAdmin",
          "servicecatalog:SearchProductsAsAdmin",
          "servicediscovery:GetNamespace",
          "servicediscovery:ListNamespaces",
          "servicediscovery:ListTagsForResource",
          "snowball:DescribeJob",
          "ssm:GetDocument",
          "ssm:GetParameters",
          "sso-directory:Describe*",
          "sso-directory:ListMembersInGroup",
          "textract:GetAdapter",
          "textract:ListAdapters",
          "textract:ListTagsForResource",
          "timestream:DescribeBatchLoadTask",
          "timestream:DescribeEndpoints",
          "timestream:DescribeScheduledQuery",
          "timestream:ListBatchLoadTasks",
          "timestream:ListDatabases",
          "timestream:ListScheduledQueries",
          "timestream:ListTables",
          "timestream:ListTagsForResource",
          "transcribe:GetMedicalTranscriptionJob",
          "transcribe:GetTranscriptionJob",
          "voiceid:ListDomains",
          "wafv2:GetIPSet",
          "wafv2:GetRuleGroup",
          "wellarchitected:GetWorkload",
          "wellarchitected:ListWorkloads",
          "workmail:DescribeOrganization",
          "workmail:ListOrganizations",
          "workmail:ListTagsForResource"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : "cassandra:Select",
        "Effect" : "Allow",
        "Resource" : [
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema/table/keyspaces",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema/table/tables",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema/table/columns",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema_mcs/table/keyspaces",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema_mcs/table/tables",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema_mcs/table/columns",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_schema_mcs/table/tags",
          "arn:${data.aws_partition.current.partition}:cassandra:*:*:/keyspace/system_multiregion_info/table/tables"
        ],
        "Sid" : "WizReadOnlyAccessToAmazonKeyspacesMetadata"
      },
      {
        "Action" : [
          "ecr-public:DescribeImages",
          "ecr-public:GetAuthorizationToken",
          "ecr-public:ListTagsForResource",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRegistryPolicy",
          "ecr:ListTagsForResource"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }#,
      # {
      #   "Action" : [
      #     "ec2:CopySnapshot",
      #     "ec2:CreateSnapshot",
      #     "ec2:DescribeSnapshots",
      #     "ec2:GetEbsEncryptionByDefault",
      #     "kms:CreateKey",
      #     "kms:DescribeKey"
      #   ],
      #   "Effect" : "Allow",
      #   "Resource" : "*"
      # },
      # {
      #   "Action" : [
      #     "ec2:CreateTags"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "ec2:CreateAction" : [
      #         "CreateSnapshot",
      #         "CopySnapshot"
      #       ]
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "arn:${data.aws_partition.current.partition}:ec2:*::snapshot/*",
      #   "Sid" : "AllowWizToCreateTagsOnCreatedAndCopiedSnapshots"
      # },
      # {
      #   "Action" : "kms:CreateAlias",
      #   "Effect" : "Allow",
      #   "Resource" : [
      #     "arn:${data.aws_partition.current.partition}:kms:*:*:alias/wizKey",
      #     "arn:${data.aws_partition.current.partition}:kms:*:*:key/*"
      #   ]
      # },
      # {
      #   "Action" : [
      #     "kms:CreateGrant",
      #     "kms:ReEncryptFrom"
      #   ],
      #   "Condition" : {
      #     "StringLike" : {
      #       "kms:ViaService" : "ec2.*.${data.aws_partition.current.dns_suffix}"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*"
      # },
      # {
      #   "Action" : [
      #     "kms:GetKeyPolicy",
      #     "kms:PutKeyPolicy"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "aws:ResourceTag/wiz" : "auto-gen-cmk"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*"
      # },
      # {
      #   "Action" : [
      #     "ec2:DeleteSnapshot"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "ec2:ResourceTag/wiz" : "auto-gen-snapshot"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*"
      # },
      # {
      #   "Action" : [
      #     "ec2:ModifySnapshotAttribute"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "ec2:ResourceTag/wiz" : [
      #         "auto-gen-snapshot",
      #         "shareable-resource"
      #       ]
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*"
      # },
      # {
      #   "Action" : [
      #     "ec2:CreateVolume"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "aws:RequestTag/wiz" : "auto-gen-volume"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*",
      #   "Sid" : "AllowWizToCreateTaggedVolumes"
      # },
      # {
      #   "Action" : "ec2:CreateTags",
      #   "Condition" : {
      #     "StringEquals" : {
      #       "ec2:CreateAction" : "CreateVolume"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*",
      #   "Sid" : "AllowWizToCreateTagsOnCreatedVolumes"
      # },
      # {
      #   "Action" : [
      #     "ec2:DeleteVolume"
      #   ],
      #   "Condition" : {
      #     "StringEquals" : {
      #       "ec2:ResourceTag/wiz" : "auto-gen-volume"
      #     }
      #   },
      #   "Effect" : "Allow",
      #   "Resource" : "*",
      #   "Sid" : "AllowWizToDeleteTaggedVolumes"
      # },
      # {
      #   "Action" : [
      #     "ec2:DescribeAvailabilityZones",
      #     "ec2:DescribeVolumes"
      #   ],
      #   "Effect" : "Allow",
      #   "Resource" : "*",
      #   "Sid" : "WizComplementaryPermissionsForTemporaryVolumes"
      # },
      # {
      #   "Action" : [
      #     "s3:GetBucketLocation",
      #     "s3:GetObject",
      #     "s3:GetObjectTagging",
      #     "s3:ListBucket"
      #   ],
      #   "Effect" : "Allow",
      #   "Resource" : [
      #     "arn:${data.aws_partition.current.partition}:s3:::*terraform*",
      #     "arn:${data.aws_partition.current.partition}:s3:::*tfstate*",
      #     "arn:${data.aws_partition.current.partition}:s3:::*tf?state*",
      #     "arn:${data.aws_partition.current.partition}:s3:::*cloudtrail*",
      #     "arn:${data.aws_partition.current.partition}:s3:::elasticbeanstalk-*",
      #     "arn:${data.aws_partition.current.partition}:s3:::amplify-*-deployment/*"
      #   ],
      #   "Sid" : "WizAccessS3"
      # }
    ],
    "Version" : "2012-10-17"
  })
}

# Create Lightsail Scanning Managed Policy
resource "aws_iam_policy" "tf-policy-lightsail" {
  name  = "WizLightsailScanningPolicy"
  count = var.lightsail-scanning ? 1 : 0
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : "iam:CreateServiceLinkedRole",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : "lightsail.${data.aws_partition.current.dns_suffix}"
          }
        },
        "Effect" : "Allow",
        "Resource" : "arn:${data.aws_partition.current.partition}:iam::*:role/aws-service-role/lightsail.${data.aws_partition.current.dns_suffix}/AWSServiceRoleForLightsail*"
      },
      {
        "Action" : [
          "iam:PutRolePolicy"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "arn:${data.aws_partition.current.partition}:iam::*:role/aws-service-role/lightsail.${data.aws_partition.current.dns_suffix}/AWSServiceRoleForLightsail*"
        ]
      },
      {
        "Action" : [
          "lightsail:CreateDiskSnapshot",
          "lightsail:TagResource"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:RequestTag/wiz" : "auto-gen-snapshot"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "lightsail:DeleteDiskSnapshot",
          "lightsail:ExportSnapshot"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/wiz" : "auto-gen-snapshot"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "lightsail:GetDiskSnapshot",
          "lightsail:GetDiskSnapshots",
          "lightsail:GetExportSnapshotRecords"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "ec2:DeleteSnapshot",
          "ec2:ModifySnapshotAttribute"
        ],
        "Condition" : {
          "StringLike" : {
            "ec2:ParentVolume" : "arn:${data.aws_partition.current.partition}:ec2:*:*:volume/vol-ffffffff"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ],
    "Version" : "2012-10-17"
  })
}

# Create Data Scanning Managed Policy
resource "aws_iam_policy" "tf-policy-data" {
  name  = "WizDataScanningPolicy"
  count = var.data-scanning ? 1 : 0
  policy = jsonencode({
    "Statement" : [
      {
        "Action" : [
          "redshift:AuthorizeSnapshotAccess",
          "redshift:DeleteClusterSnapshot",
          "redshift:RevokeSnapshotAccess"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:${data.aws_partition.current.partition}:redshift:*:*:snapshot:*wiz-autogen-*"
      },
      {
        "Action" : [
          "redshift:CopyClusterSnapshot"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "redshift:CreateTags"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:${data.aws_partition.current.partition}:redshift:*:*:snapshot:*/*"
      },
      {
        "Action" : [
          "redshift:DescribeClusterSnapshots",
          "redshift:DescribeClusters"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "redshift:CreateClusterSnapshot"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:RequestTag/wiz" : "auto-gen-snapshot"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "rds:AddTagsToResource",
          "rds:DescribeAccountAttributes",
          "rds:DescribeDBClusterSnapshots",
          "rds:DescribeDBClusters",
          "rds:DescribeDBInstances",
          "rds:DescribeDBSnapshots",
          "rds:DescribeDBSubnetGroups",
          "rds:ListTagsForResource"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "rds:DeleteDBClusterSnapshot",
          "rds:ModifyDBClusterSnapshotAttribute"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:${data.aws_partition.current.partition}:rds:*:*:cluster-snapshot:wiz-autogen-*"
      },
      {
        "Action" : [
          "rds:CopyDBClusterSnapshot",
          "rds:CopyDBSnapshot"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "rds:DeleteDBSnapshot",
          "rds:ModifyDBSnapshotAttribute"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:${data.aws_partition.current.partition}:rds:*:*:snapshot:wiz-autogen-*"
      },
      {
        "Action" : [
          "rds:CreateDBClusterSnapshot",
          "rds:CreateDBSnapshot"
        ],
        "Condition" : {
          "StringEquals" : {
            "rds:req-tag/wiz" : "auto-gen-snapshot"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket",
          "s3express:CreateSession"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "kms:CreateGrant",
          "kms:ReEncrypt*"
        ],
        "Condition" : {
          "StringLike" : {
            "kms:ViaService" : "rds.*.${data.aws_partition.current.dns_suffix}"
          }
        },
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "dynamodb:DescribeTable",
          "dynamodb:Scan"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ],
    "Version" : "2012-10-17"
  })
}

## Attach Lightsail IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "lightsail-scanning-attach" {
  count      = var.lightsail-scanning ? 1 : 0
  role       = aws_iam_role.user-role-tf.name
  policy_arn = aws_iam_policy.tf-policy-lightsail[0].arn
}

## Attach Data Scanning IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "data-scanning-attach" {
  count      = var.data-scanning ? 1 : 0
  role       = aws_iam_role.user-role-tf.name
  policy_arn = aws_iam_policy.tf-policy-data[0].arn
}
