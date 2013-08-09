{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

-- |
-- Module      : Network.AWS.AutoScaling
-- Copyright   : (c) 2013 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--              , the Mozilla Public License, v. 2.0.
--              , A copy of the MPL can be found in the LICENSE file or
--              , you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Network.AWS.AutoScaling where

import Control.Applicative
import Data.Aeson
import Data.Aeson.TH
import Data.ByteString               (ByteString)
import Data.Monoid
import Data.String
import Data.Text                     (Text)
import Network.AWS.AutoScaling.Types
import Network.AWS.Internal
import Network.Http.Client           hiding (get)

--
-- AutoScaling Requests
--

data AutoScaling

instance AWSService AutoScaling where
    service _ = awsService "autoscaling" (toBS version) SigningVersion4

version :: Text
version = "2011-01-01"

req :: (QueryString a, FromJSON b) => ByteString -> a -> AWS (RawRequest AutoScaling b)
req meth action qry = return $ (emptyRequest meth FormEncoded "" Nothing)
    { rqAction = Just action
    , rqQuery  = queryString qry
    }

--
-- Actions
--

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_CreateAutoScalingGroup.html>
-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_CreateAutoScalingGroup.html>
data CreateAutoScalingGroup = CreateAutoScalingGroup
    { casgAutoScalingGroupName :: !Text
    , casgLaunchConfigurationName :: !ResourceName
    , casgMinSize :: !Integer
    , casgMaxSize :: !Integer
    , casgDesiredCapacity :: !(Maybe Integer)
    , casgDefaultCooldown :: !(Maybe Integer)
    , casgAvailabilityZones :: !(Maybe AvailabilityZones)
    , casgLoadBalancerNames :: !(Maybe LoadBalancerNames)
    , casgHealthCheckType :: !(Maybe Text)
    , casgHealthCheckGracePeriod :: !(Maybe Integer)
    , casgPlacementGroup :: !(Maybe Text)
    , casgVPCZoneIdentifier :: !(Maybe Text)
    , casgTerminationPolicies :: !(Maybe TerminationPolicies)
    , casgTags :: !(Maybe Tags)
    } deriving (Show)

$(deriveQS ''CreateAutoScalingGroup)

instance AWSRequest AutoScaling CreateAutoScalingGroup CreateAutoScalingGroupResponse where
    request = req GET "CreateAutoScalingGroup"

$(deriveQS ''CreateAutoScalingGroup)

instance AWSRequest AutoScaling CreateAutoScalingGroup CreateAutoScalingGroupResponse where
    request = req GET "CreateAutoScalingGroup"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_CreateLaunchConfiguration.html>
data CreateLaunchConfiguration = CreateLaunchConfiguration
    { clcLaunchConfigurationName :: !Text
    , clcImageId :: !Text
    , clcKeyName :: !(Maybe Text)
    , clcSecurityGroups :: !(Maybe SecurityGroups)
    , clcUserData :: !(Maybe Text)
    , clcInstanceType :: !Text
    , clcKernelId :: !(Maybe Text)
    , clcRamdiskId :: !(Maybe Text)
    , clcBlockDeviceMappings :: !(Maybe BlockDeviceMappings)
    , clcInstanceMonitoring :: !(Maybe InstanceMonitoring)
    , clcSpotPrice :: !(Maybe Text)
    , clcIamInstanceProfile :: !(Maybe Text)
    , clcEbsOptimized :: !(Maybe Boolean)
    } deriving (Show)

$(deriveQS ''CreateLaunchConfiguration)

instance AWSRequest AutoScaling CreateLaunchConfiguration CreateLaunchConfigurationResponse where
    request = req GET "CreateLaunchConfiguration"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_CreateOrUpdateTags.html>
data CreateOrUpdateTags = CreateOrUpdateTags
    { coutTags :: !Tags
    } deriving (Show)

$(deriveQS ''CreateOrUpdateTags)

instance AWSRequest AutoScaling CreateOrUpdateTags CreateOrUpdateTagsResponse where
    request = req GET "CreateOrUpdateTags"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeleteAutoScalingGroup.html>
data DeleteAutoScalingGroup = DeleteAutoScalingGroup
    { dasgAutoScalingGroupName :: !ResourceName
    , dasgForceDelete :: !(Maybe Boolean)
    } deriving (Show)

$(deriveQS ''DeleteAutoScalingGroup)

instance AWSRequest AutoScaling DeleteAutoScalingGroup DeleteAutoScalingGroupResponse where
    request = req GET "DeleteAutoScalingGroup"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeleteLaunchConfiguration.html>
data DeleteLaunchConfiguration = DeleteLaunchConfiguration
    { dlcLaunchConfigurationName :: !ResourceName
    } deriving (Show)

$(deriveQS ''DeleteLaunchConfiguration)

instance AWSRequest AutoScaling DeleteLaunchConfiguration DeleteLaunchConfigurationResponse where
    request = req GET "DeleteLaunchConfiguration"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeleteNotificationConfiguration.html>
data DeleteNotificationConfiguration = DeleteNotificationConfiguration
    { dncAutoScalingGroupName :: !ResourceName
    , dncTopicARN :: !ResourceName
    } deriving (Show)

$(deriveQS ''DeleteNotificationConfiguration)

instance AWSRequest AutoScaling DeleteNotificationConfiguration DeleteNotificationConfigurationResponse where
    request = req GET "DeleteNotificationConfiguration"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeletePolicy.html>
data DeletePolicy = DeletePolicy
    { dpAutoScalingGroupName :: !(Maybe ResourceName)
    , dpPolicyName :: !ResourceName
    } deriving (Show)

$(deriveQS ''DeletePolicy)

instance AWSRequest AutoScaling DeletePolicy DeletePolicyResponse where
    request = req GET "DeletePolicy"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeleteScheduledAction.html>
data DeleteScheduledAction = DeleteScheduledAction
    { dsaAutoScalingGroupName :: !(Maybe ResourceName)
    , dsaScheduledActionName :: !ResourceName
    } deriving (Show)

$(deriveQS ''DeleteScheduledAction)

instance AWSRequest AutoScaling DeleteScheduledAction DeleteScheduledActionResponse where
    request = req GET "DeleteScheduledAction"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DeleteTags.html>
data DeleteTags = DeleteTags
    { dtTags :: !Tags
    } deriving (Show)

$(deriveQS ''DeleteTags)

instance AWSRequest AutoScaling DeleteTags DeleteTagsResponse where
    request = req GET "DeleteTags"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeAdjustmentTypes.html>
data DescribeAdjustmentTypes = DescribeAdjustmentTypes
    deriving (Show)

$(deriveQS ''DescribeAdjustmentTypes)

instance AWSRequest AutoScaling DescribeAdjustmentTypes DescribeAdjustmentTypesResponse where
    request = req GET "DescribeAdjustmentTypes"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeAutoScalingGroups.html>
data DescribeAutoScalingGroups = DescribeAutoScalingGroups
    { dasgAutoScalingGroupNames :: !(Maybe AutoScalingGroupNames)
    , dasgNextToken :: !(Maybe Text)
    , dasgMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribeAutoScalingGroups)

instance AWSRequest AutoScaling DescribeAutoScalingGroups DescribeAutoScalingGroupsResponse where
    request = req GET "DescribeAutoScalingGroups"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeAutoScalingInstances.html>
data DescribeAutoScalingInstances = DescribeAutoScalingInstances
    { dasiInstanceIds :: !(Maybe InstanceIds)
    , dasiMaxRecords :: !(Maybe Integer)
    , dasiNextToken :: !(Maybe Text)
    } deriving (Show)

$(deriveQS ''DescribeAutoScalingInstances)

instance AWSRequest AutoScaling DescribeAutoScalingInstances DescribeAutoScalingInstancesResponse where
    request = req GET "DescribeAutoScalingInstances"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_AutoScalingNotificationTypes.html>
data AutoScalingNotificationTypes = AutoScalingNotificationTypes
    { asntMember :: ![Text]
    } deriving (Show)

$(deriveQS ''AutoScalingNotificationTypes)

instance AWSRequest AutoScaling AutoScalingNotificationTypes AutoScalingNotificationTypesResponse where
    request = req GET "AutoScalingNotificationTypes"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeLaunchConfigurations.html>
data DescribeLaunchConfigurations = DescribeLaunchConfigurations
    { dlcLaunchConfigurationNames :: !(Maybe LaunchConfigurationNames)
    , dlcNextToken :: !(Maybe Text)
    , dlcMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribeLaunchConfigurations)

instance AWSRequest AutoScaling DescribeLaunchConfigurations DescribeLaunchConfigurationsResponse where
    request = req GET "DescribeLaunchConfigurations"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeMetricCollectionTypes.html>
data DescribeMetricCollectionTypes = DescribeMetricCollectionTypes
    deriving (Show)

$(deriveQS ''DescribeMetricCollectionTypes)

instance AWSRequest AutoScaling DescribeMetricCollectionTypes DescribeMetricCollectionTypesResponse where
    request = req GET "DescribeMetricCollectionTypes"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeNotificationConfigurations.html>
data DescribeNotificationConfigurations = DescribeNotificationConfigurations
    { dncAutoScalingGroupNames :: !(Maybe AutoScalingGroupNames)
    , dncNextToken :: !(Maybe Text)
    , dncMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribeNotificationConfigurations)

instance AWSRequest AutoScaling DescribeNotificationConfigurations DescribeNotificationConfigurationsResponse where
    request = req GET "DescribeNotificationConfigurations"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribePolicies.html>
data DescribePolicies = DescribePolicies
    { dpAutoScalingGroupName :: !(Maybe ResourceName)
    , dpPolicyNames :: !(Maybe PolicyNames)
    , dpNextToken :: !(Maybe Text)
    , dpMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribePolicies)

instance AWSRequest AutoScaling DescribePolicies DescribePoliciesResponse where
    request = req GET "DescribePolicies"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeScalingProcessTypes.html>
data DescribeScalingProcessTypes = DescribeScalingProcessTypes
    deriving (Show)

$(deriveQS ''DescribeScalingProcessTypes)

instance AWSRequest AutoScaling DescribeScalingProcessTypes DescribeScalingProcessTypesResponse where
    request = req GET "DescribeScalingProcessTypes"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeScalingActivities.html>
data DescribeScalingActivities = DescribeScalingActivities
    { dsaActivityIds :: !(Maybe ActivityIds)
    , dsaAutoScalingGroupName :: !(Maybe ResourceName)
    , dsaMaxRecords :: !(Maybe Integer)
    , dsaNextToken :: !(Maybe Text)
    } deriving (Show)

$(deriveQS ''DescribeScalingActivities)

instance AWSRequest AutoScaling DescribeScalingActivities DescribeScalingActivitiesResponse where
    request = req GET "DescribeScalingActivities"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeScheduledActions.html>
data DescribeScheduledActions = DescribeScheduledActions
    { dsaAutoScalingGroupName :: !(Maybe ResourceName)
    , dsaScheduledActionNames :: !(Maybe ScheduledActionNames)
    , dsaStartTime :: !(Maybe DateTime)
    , dsaEndTime :: !(Maybe DateTime)
    , dsaNextToken :: !(Maybe Text)
    , dsaMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribeScheduledActions)

instance AWSRequest AutoScaling DescribeScheduledActions DescribeScheduledActionsResponse where
    request = req GET "DescribeScheduledActions"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeTags.html>
data DescribeTags = DescribeTags
    { dtFilters :: !(Maybe Filters)
    , dtNextToken :: !(Maybe Text)
    , dtMaxRecords :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''DescribeTags)

instance AWSRequest AutoScaling DescribeTags DescribeTagsResponse where
    request = req GET "DescribeTags"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DescribeTerminationPolicyTypes.html>
data DescribeTerminationPolicyTypes = DescribeTerminationPolicyTypes
    deriving (Show)

$(deriveQS ''DescribeTerminationPolicyTypes)

instance AWSRequest AutoScaling DescribeTerminationPolicyTypes DescribeTerminationPolicyTypesResponse where
    request = req GET "DescribeTerminationPolicyTypes"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_DisableMetricsCollection.html>
data DisableMetricsCollection = DisableMetricsCollection
    { dmcAutoScalingGroupName :: !ResourceName
    , dmcMetrics :: !(Maybe Metrics)
    } deriving (Show)

$(deriveQS ''DisableMetricsCollection)

instance AWSRequest AutoScaling DisableMetricsCollection DisableMetricsCollectionResponse where
    request = req GET "DisableMetricsCollection"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_EnableMetricsCollection.html>
data EnableMetricsCollection = EnableMetricsCollection
    { emcAutoScalingGroupName :: !ResourceName
    , emcMetrics :: !(Maybe Metrics)
    , emcGranularity :: !Text
    } deriving (Show)

$(deriveQS ''EnableMetricsCollection)

instance AWSRequest AutoScaling EnableMetricsCollection EnableMetricsCollectionResponse where
    request = req GET "EnableMetricsCollection"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_ExecutePolicy.html>
data ExecutePolicy = ExecutePolicy
    { epAutoScalingGroupName :: !(Maybe ResourceName)
    , epPolicyName :: !ResourceName
    , epHonorCooldown :: !(Maybe Boolean)
    } deriving (Show)

$(deriveQS ''ExecutePolicy)

instance AWSRequest AutoScaling ExecutePolicy ExecutePolicyResponse where
    request = req GET "ExecutePolicy"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_PutNotificationConfiguration.html>
data PutNotificationConfiguration = PutNotificationConfiguration
    { pncAutoScalingGroupName :: !ResourceName
    , pncTopicARN :: !ResourceName
    , pncNotificationTypes :: !AutoScalingNotificationTypes
    } deriving (Show)

$(deriveQS ''PutNotificationConfiguration)

instance AWSRequest AutoScaling PutNotificationConfiguration PutNotificationConfigurationResponse where
    request = req GET "PutNotificationConfiguration"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_PutScalingPolicy.html>
data PutScalingPolicy = PutScalingPolicy
    { pspAutoScalingGroupName :: !ResourceName
    , pspPolicyName :: !Text
    , pspScalingAdjustment :: !Integer
    , pspAdjustmentType :: !Text
    , pspCooldown :: !(Maybe Integer)
    , pspMinAdjustmentStep :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''PutScalingPolicy)

instance AWSRequest AutoScaling PutScalingPolicy PutScalingPolicyResponse where
    request = req GET "PutScalingPolicy"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_PutScheduledUpdateGroupAction.html>
data PutScheduledUpdateGroupAction = PutScheduledUpdateGroupAction
    { psugaAutoScalingGroupName :: !ResourceName
    , psugaScheduledActionName :: !Text
    , psugaTime :: !(Maybe DateTime)
    , psugaStartTime :: !(Maybe DateTime)
    , psugaEndTime :: !(Maybe DateTime)
    , psugaRecurrence :: !(Maybe Text)
    , psugaMinSize :: !(Maybe Integer)
    , psugaMaxSize :: !(Maybe Integer)
    , psugaDesiredCapacity :: !(Maybe Integer)
    } deriving (Show)

$(deriveQS ''PutScheduledUpdateGroupAction)

instance AWSRequest AutoScaling PutScheduledUpdateGroupAction PutScheduledUpdateGroupActionResponse where
    request = req GET "PutScheduledUpdateGroupAction"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_ResumeProcesses.html>
data ResumeProcesses = ResumeProcesses
    { rpAutoScalingGroupName :: !ResourceName
    , rpScalingProcesses :: !(Maybe ProcessNames)
    } deriving (Show)

$(deriveQS ''ResumeProcesses)

instance AWSRequest AutoScaling ResumeProcesses ResumeProcessesResponse where
    request = req GET "ResumeProcesses"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_SetDesiredCapacity.html>
data SetDesiredCapacity = SetDesiredCapacity
    { sdcAutoScalingGroupName :: !ResourceName
    , sdcDesiredCapacity :: !Integer
    , sdcHonorCooldown :: !(Maybe Boolean)
    } deriving (Show)

$(deriveQS ''SetDesiredCapacity)

instance AWSRequest AutoScaling SetDesiredCapacity SetDesiredCapacityResponse where
    request = req GET "SetDesiredCapacity"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_SetInstanceHealth.html>
data SetInstanceHealth = SetInstanceHealth
    { sihInstanceId :: !Text
    , sihHealthStatus :: !Text
    , sihShouldRespectGracePeriod :: !(Maybe Boolean)
    } deriving (Show)

$(deriveQS ''SetInstanceHealth)

instance AWSRequest AutoScaling SetInstanceHealth SetInstanceHealthResponse where
    request = req GET "SetInstanceHealth"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_SuspendProcesses.html>
data SuspendProcesses = SuspendProcesses
    { spAutoScalingGroupName :: !ResourceName
    , spScalingProcesses :: !(Maybe ProcessNames)
    } deriving (Show)

$(deriveQS ''SuspendProcesses)

instance AWSRequest AutoScaling SuspendProcesses SuspendProcessesResponse where
    request = req GET "SuspendProcesses"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_TerminateInstanceInAutoScalingGroup.html>
data TerminateInstanceInAutoScalingGroup = TerminateInstanceInAutoScalingGroup
    { tiiasgInstanceId :: !Text
    , tiiasgShouldDecrementDesiredCapacity :: !Boolean
    } deriving (Show)

$(deriveQS ''TerminateInstanceInAutoScalingGroup)

instance AWSRequest AutoScaling TerminateInstanceInAutoScalingGroup TerminateInstanceInAutoScalingGroupResponse where
    request = req GET "TerminateInstanceInAutoScalingGroup"

-- |
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_UpdateAutoScalingGroup.html>
data UpdateAutoScalingGroup = UpdateAutoScalingGroup
    { uasgAutoScalingGroupName :: !ResourceName
    , uasgLaunchConfigurationName :: !(Maybe ResourceName)
    , uasgMinSize :: !(Maybe Integer)
    , uasgMaxSize :: !(Maybe Integer)
    , uasgDesiredCapacity :: !(Maybe Integer)
    , uasgDefaultCooldown :: !(Maybe Integer)
    , uasgAvailabilityZones :: !(Maybe AvailabilityZones)
    , uasgHealthCheckType :: !(Maybe Text)
    , uasgHealthCheckGracePeriod :: !(Maybe Integer)
    , uasgPlacementGroup :: !(Maybe Text)
    , uasgVPCZoneIdentifier :: !(Maybe Text)
    , uasgTerminationPolicies :: !(Maybe TerminationPolicies)
    } deriving (Show)

$(deriveQS ''UpdateAutoScalingGroup)

instance AWSRequest AutoScaling UpdateAutoScalingGroup UpdateAutoScalingGroupResponse where
    request = req GET "UpdateAutoScalingGroup"
