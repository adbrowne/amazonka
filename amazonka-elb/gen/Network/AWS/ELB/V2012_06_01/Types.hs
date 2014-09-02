{-# LANGUAGE DeriveDataTypeable          #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE StandaloneDeriving          #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.ELB.V2012_06_01.Types
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Elastic Load Balancing automatically distributes incoming application
-- traffic across multiple Amazon EC2 instances. It enables you to achieve
-- greater levels of fault tolerance in your applications, seamlessly
-- providing the required amount of load balancing capacity needed to
-- distribute application traffic.
module Network.AWS.ELB.V2012_06_01.Types
    ( module Network.AWS.ELB.V2012_06_01.Types
    ) where

import Network.AWS.Prelude
import Network.AWS.Signing.V4

-- | Supported version (@2012-06-01@) of the
-- @Elastic Load Balancing@ service.
data ELB deriving (Typeable)

instance AWSService ELB where
    type Sg ELB = V4
    data Er ELB
        = AccessPointNotFoundException
        | CertificateNotFoundException
        | DuplicateAccessPointNameException
        | DuplicateListenerException
        | DuplicatePolicyNameException
        | DuplicateTagKeysException
        | ELBClient HttpException
        | ELBSerializer String
        | ELBService String
        | InvalidConfigurationRequestException
        | InvalidEndPointException
        | InvalidSchemeException
        | InvalidSecurityGroupException
        | InvalidSubnetException
        | ListenerNotFoundException
        | LoadBalancerAttributeNotFoundException
        | PolicyNotFoundException
        | PolicyTypeNotFoundException
        | SubnetNotFoundException
        | TooManyAccessPointsException
        | TooManyPoliciesException
        | TooManyTagsException

    service = Service'
        { _svcEndpoint = Regional
        , _svcPrefix   = "elasticloadbalancing"
        , _svcVersion  = "2012-06-01"
        , _svcTarget   = Nothing
        }

deriving instance Show    (Er ELB)
deriving instance Generic (Er ELB)

instance AWSError (Er ELB) where
    awsError = const "ELBError"

instance AWSServiceError (Er ELB) where
    serviceError    = ELBService
    clientError     = ELBClient
    serializerError = ELBSerializer

instance Exception (Er ELB)

xmlOptions :: Tagged a XMLOptions
xmlOptions = Tagged def
    { xmlNamespace = Just "http://elasticloadbalancing.amazonaws.com/doc/2012-06-01/"
    }

-- | The name of the load balancer attribute. By default, Elastic Load Balancing
-- maintains a 60-second idle connection timeout for both front-end and
-- back-end connections of your load balancer. If the ConnectionSettings
-- attribute is set, Elastic Load Balancing will allow the connections to
-- remain idle (no data is sent over the connection) for the specified
-- duration. For more information, see Configure Idle Connection Timeout.
newtype ConnectionSettings = ConnectionSettings
    { _csIdleTimeout :: Integer
      -- ^ Specifies the time (in seconds) the connection is allowed to be
      -- idle (no data has been sent over the connection) before it is
      -- closed by the load balancer.
    } deriving (Show, Generic)

instance FromXML ConnectionSettings where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "ConnectionSettings"

instance ToQuery ConnectionSettings where
    toQuery = genericQuery def

-- | The name of the load balancer attribute. If enabled, the load balancer
-- routes the request traffic evenly across all back-end instances regardless
-- of the Availability Zones. For more information, see Enable Cross-Zone Load
-- Balancing.
newtype CrossZoneLoadBalancing = CrossZoneLoadBalancing
    { _czlbEnabled :: Bool
      -- ^ Specifies whether cross-zone load balancing is enabled for the
      -- load balancer.
    } deriving (Show, Generic)

instance FromXML CrossZoneLoadBalancing where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "CrossZoneLoadBalancing"

instance ToQuery CrossZoneLoadBalancing where
    toQuery = genericQuery def

-- | The Instance data type.
newtype Instance = Instance
    { _jInstanceId :: Maybe Text
      -- ^ Provides an EC2 instance ID.
    } deriving (Show, Generic)

instance FromXML Instance where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Instance"

instance ToQuery Instance where
    toQuery = genericQuery def

-- | The key of a tag to be removed.
newtype TagKeyOnly = TagKeyOnly
    { _tkoKey :: Maybe Text
      -- ^ The name of the key.
    } deriving (Show, Generic)

instance ToQuery TagKeyOnly where
    toQuery = genericQuery def

-- | The name of the load balancer attribute. If enabled, the load balancer
-- captures detailed information of all the requests and delivers the
-- information to the Amazon S3 bucket that you specify. For more information,
-- see Enable Access Logs.
data AccessLog = AccessLog
    { _alS3BucketName :: Maybe Text
      -- ^ The name of the Amazon S3 bucket where the access logs are
      -- stored.
    , _alS3BucketPrefix :: Maybe Text
      -- ^ The logical hierarchy you created for your Amazon S3 bucket, for
      -- example my-bucket-prefix/prod. If the prefix is not provided, the
      -- log is placed at the root level of the bucket.
    , _alEnabled :: Bool
      -- ^ Specifies whether access log is enabled for the load balancer.
    , _alEmitInterval :: Maybe Integer
      -- ^ The interval for publishing the access logs. You can specify an
      -- interval of either 5 minutes or 60 minutes. Default: 60 minutes.
    } deriving (Show, Generic)

instance FromXML AccessLog where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "AccessLog"

instance ToQuery AccessLog where
    toQuery = genericQuery def

-- | The AppCookieStickinessPolicy data type.
data AppCookieStickinessPolicy = AppCookieStickinessPolicy
    { _acsqCookieName :: Maybe Text
      -- ^ The name of the application cookie used for stickiness.
    , _acsqPolicyName :: Maybe Text
      -- ^ The mnemonic name for the policy being created. The name must be
      -- unique within a set of policies for this load balancer.
    } deriving (Show, Generic)

instance FromXML AppCookieStickinessPolicy where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "AppCookieStickinessPolicy"

instance ToQuery AppCookieStickinessPolicy where
    toQuery = genericQuery def

-- | This data type is used as a response element in the DescribeLoadBalancers
-- action to describe the configuration of the back-end server.
data BackendServerDescription = BackendServerDescription
    { _bseInstancePort :: Maybe Integer
      -- ^ Provides the port on which the back-end server is listening.
    , _bsePolicyNames :: [Text]
      -- ^ Provides a list of policy names enabled for the back-end server.
    } deriving (Show, Generic)

instance FromXML BackendServerDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "BackendServerDescription"

instance ToQuery BackendServerDescription where
    toQuery = genericQuery def

-- | The name of the load balancer attribute. If enabled, the load balancer
-- allows existing requests to complete before the load balancer shifts
-- traffic away from a deregistered or unhealthy back-end instance. For more
-- information, see Enable Connection Draining.
data ConnectionDraining = ConnectionDraining
    { _cdTimeout :: Maybe Integer
      -- ^ Specifies the maximum time (in seconds) to keep the existing
      -- connections open before deregistering the instances.
    , _cdEnabled :: Bool
      -- ^ Specifies whether connection draining is enabled for the load
      -- balancer.
    } deriving (Show, Generic)

instance FromXML ConnectionDraining where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "ConnectionDraining"

instance ToQuery ConnectionDraining where
    toQuery = genericQuery def

-- | Specifies information regarding the various health probes conducted on the
-- load balancer.
data HealthCheck = HealthCheck
    { _hcTarget :: Text
      -- ^ Specifies the instance being checked. The protocol is either TCP,
      -- HTTP, HTTPS, or SSL. The range of valid ports is one (1) through
      -- 65535. TCP is the default, specified as a TCP: port pair, for
      -- example "TCP:5000". In this case a healthcheck simply attempts to
      -- open a TCP connection to the instance on the specified port.
      -- Failure to connect within the configured timeout is considered
      -- unhealthy. SSL is also specified as SSL: port pair, for example,
      -- SSL:5000. For HTTP or HTTPS protocol, the situation is different.
      -- You have to include a ping path in the string. HTTP is specified
      -- as a HTTP:port;/;PathToPing; grouping, for example
      -- "HTTP:80/weather/us/wa/seattle". In this case, a HTTP GET request
      -- is issued to the instance on the given port and path. Any answer
      -- other than "200 OK" within the timeout period is considered
      -- unhealthy. The total length of the HTTP ping target needs to be
      -- 1024 16-bit Unicode characters or less.
    , _hcUnhealthyThreshold :: Integer
      -- ^ Specifies the number of consecutive health probe failures
      -- required before moving the instance to the Unhealthy state.
    , _hcTimeout :: Integer
      -- ^ Specifies the amount of time, in seconds, during which no
      -- response means a failed health probe. This value must be less
      -- than the Interval value.
    , _hcInterval :: Integer
      -- ^ Specifies the approximate interval, in seconds, between health
      -- checks of an individual instance.
    , _hcHealthyThreshold :: Integer
      -- ^ Specifies the number of consecutive health probe successes
      -- required before moving the instance to the Healthy state.
    } deriving (Show, Generic)

instance FromXML HealthCheck where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "HealthCheck"

instance ToQuery HealthCheck where
    toQuery = genericQuery def

-- | The InstanceState data type.
data InstanceState = InstanceState
    { _ivDescription :: Maybe Text
      -- ^ Provides a description of the instance state.
    , _ivReasonCode :: Maybe Text
      -- ^ Provides information about the cause of OutOfService instances.
      -- Specifically, it indicates whether the cause is Elastic Load
      -- Balancing or the instance behind the load balancer. Valid value:
      -- ELB|Instance|N/A.
    , _ivState :: Maybe Text
      -- ^ Specifies the current state of the instance. Valid value:
      -- InService|OutOfService|Unknown.
    , _ivInstanceId :: Maybe Text
      -- ^ Provides an EC2 instance ID.
    } deriving (Show, Generic)

instance FromXML InstanceState where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "InstanceState"

-- | The LBCookieStickinessPolicy data type.
data LBCookieStickinessPolicy = LBCookieStickinessPolicy
    { _lbcsqCookieExpirationPeriod :: Maybe Integer
      -- ^ The time period in seconds after which the cookie should be
      -- considered stale. Not specifying this parameter indicates that
      -- the stickiness session will last for the duration of the browser
      -- session.
    , _lbcsqPolicyName :: Maybe Text
      -- ^ The name for the policy being created. The name must be unique
      -- within the set of policies for this load balancer.
    } deriving (Show, Generic)

instance FromXML LBCookieStickinessPolicy where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "LBCookieStickinessPolicy"

instance ToQuery LBCookieStickinessPolicy where
    toQuery = genericQuery def

-- | The Listener data type.
data Listener = Listener
    { _lSSLCertificateId :: Maybe Text
      -- ^ The ARN string of the server certificate. To get the ARN of the
      -- server certificate, call the AWS Identity and Access Management
      -- UploadServerCertificate API.
    , _lProtocol :: Text
      -- ^ Specifies the load balancer transport protocol to use for routing
      -- - HTTP, HTTPS, TCP or SSL. This property cannot be modified for
      -- the life of the load balancer.
    , _lLoadBalancerPort :: Integer
      -- ^ Specifies the external load balancer port number. This property
      -- cannot be modified for the life of the load balancer.
    , _lInstancePort :: Integer
      -- ^ Specifies the TCP port on which the instance server is listening.
      -- This property cannot be modified for the life of the load
      -- balancer.
    , _lInstanceProtocol :: Maybe Text
      -- ^ Specifies the protocol to use for routing traffic to back-end
      -- instances - HTTP, HTTPS, TCP, or SSL. This property cannot be
      -- modified for the life of the load balancer. If the front-end
      -- protocol is HTTP or HTTPS, InstanceProtocol has to be at the same
      -- protocol layer, i.e., HTTP or HTTPS. Likewise, if the front-end
      -- protocol is TCP or SSL, InstanceProtocol has to be TCP or SSL. If
      -- there is another listener with the same InstancePort whose
      -- InstanceProtocol is secure, i.e., HTTPS or SSL, the listener's
      -- InstanceProtocol has to be secure, i.e., HTTPS or SSL. If there
      -- is another listener with the same InstancePort whose
      -- InstanceProtocol is HTTP or TCP, the listener's InstanceProtocol
      -- must be either HTTP or TCP.
    } deriving (Show, Generic)

instance FromXML Listener where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Listener"

instance ToQuery Listener where
    toQuery = genericQuery def

-- | The ListenerDescription data type.
data ListenerDescription = ListenerDescription
    { _leListener :: Maybe Listener
      -- ^ The Listener data type.
    , _lePolicyNames :: [Text]
      -- ^ A list of policies enabled for this listener. An empty list
      -- indicates that no policies are enabled.
    } deriving (Show, Generic)

instance FromXML ListenerDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "ListenerDescription"

instance ToQuery ListenerDescription where
    toQuery = genericQuery def

-- | Attributes of the load balancer.
data LoadBalancerAttributes = LoadBalancerAttributes
    { _lbaConnectionDraining :: Maybe ConnectionDraining
      -- ^ The name of the load balancer attribute. If enabled, the load
      -- balancer allows existing requests to complete before the load
      -- balancer shifts traffic away from a deregistered or unhealthy
      -- back-end instance. For more information, see Enable Connection
      -- Draining.
    , _lbaConnectionSettings :: Maybe ConnectionSettings
      -- ^ The name of the load balancer attribute. By default, Elastic Load
      -- Balancing maintains a 60-second idle connection timeout for both
      -- front-end and back-end connections of your load balancer. If the
      -- ConnectionSettings attribute is set, Elastic Load Balancing will
      -- allow the connections to remain idle (no data is sent over the
      -- connection) for the specified duration. For more information, see
      -- Configure Idle Connection Timeout.
    , _lbaAccessLog :: Maybe AccessLog
      -- ^ The name of the load balancer attribute. If enabled, the load
      -- balancer captures detailed information of all the requests and
      -- delivers the information to the Amazon S3 bucket that you
      -- specify. For more information, see Enable Access Logs.
    , _lbaCrossZoneLoadBalancing :: Maybe CrossZoneLoadBalancing
      -- ^ The name of the load balancer attribute. If enabled, the load
      -- balancer routes the request traffic evenly across all back-end
      -- instances regardless of the Availability Zones. For more
      -- information, see Enable Cross-Zone Load Balancing.
    } deriving (Show, Generic)

instance FromXML LoadBalancerAttributes where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "LoadBalancerAttributes"

instance ToQuery LoadBalancerAttributes where
    toQuery = genericQuery def

-- | Contains the result of a successful invocation of DescribeLoadBalancers.
data LoadBalancerDescription = LoadBalancerDescription
    { _lbePolicies :: Maybe Policies
      -- ^ Provides a list of policies defined for the load balancer.
    , _lbeDNSName :: Maybe Text
      -- ^ Specifies the external DNS name associated with the load
      -- balancer.
    , _lbeListenerDescriptions :: [ListenerDescription]
      -- ^ LoadBalancerPort, InstancePort, Protocol, InstanceProtocol, and
      -- PolicyNames are returned in a list of tuples in the
      -- ListenerDescriptions element.
    , _lbeScheme :: Maybe Text
      -- ^ Specifies the type of load balancer. If the Scheme is
      -- internet-facing, the load balancer has a publicly resolvable DNS
      -- name that resolves to public IP addresses. If the Scheme is
      -- internal, the load balancer has a publicly resolvable DNS name
      -- that resolves to private IP addresses. This option is only
      -- available for load balancers attached to an Amazon VPC.
    , _lbeInstances :: [Instance]
      -- ^ Provides a list of EC2 instance IDs for the load balancer.
    , _lbeCanonicalHostedZoneNameID :: Maybe Text
      -- ^ Provides the ID of the Amazon Route 53 hosted zone name that is
      -- associated with the load balancer. For information on how to
      -- associate or disassociate your load balancer with a hosted zone,
      -- go to Using Domain Names With Elastic Load Balancing in the
      -- Elastic Load Balancing Developer Guide.
    , _lbeBackendServerDescriptions :: [BackendServerDescription]
      -- ^ Contains a list of back-end server descriptions.
    , _lbeAvailabilityZones :: [Text]
      -- ^ Specifies a list of Availability Zones.
    , _lbeSubnets :: [Text]
      -- ^ Provides a list of VPC subnet IDs for the load balancer.
    , _lbeVPCId :: Maybe Text
      -- ^ Provides the ID of the VPC attached to the load balancer.
    , _lbeCreatedTime :: Maybe ISO8601
      -- ^ Provides the date and time the load balancer was created.
    , _lbeLoadBalancerName :: Maybe Text
      -- ^ Specifies the name associated with the load balancer.
    , _lbeHealthCheck :: Maybe HealthCheck
      -- ^ Specifies information regarding the various health probes
      -- conducted on the load balancer.
    , _lbeSecurityGroups :: [Text]
      -- ^ The security groups the load balancer is a member of (VPC only).
    , _lbeCanonicalHostedZoneName :: Maybe Text
      -- ^ Provides the name of the Amazon Route 53 hosted zone that is
      -- associated with the load balancer. For information on how to
      -- associate your load balancer with a hosted zone, go to Using
      -- Domain Names With Elastic Load Balancing in the Elastic Load
      -- Balancing Developer Guide.
    , _lbeSourceSecurityGroup :: Maybe SourceSecurityGroup
      -- ^ The security group that you can use as part of your inbound rules
      -- for your load balancer's back-end Amazon EC2 application
      -- instances. To only allow traffic from load balancers, add a
      -- security group rule to your back end instance that specifies this
      -- source security group as the inbound source.
    } deriving (Show, Generic)

instance FromXML LoadBalancerDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "LoadBalancerDescription"

-- | Provides a list of policies defined for the load balancer.
data Policies = Policies
    { _rAppCookieStickinessPolicies :: [AppCookieStickinessPolicy]
      -- ^ A list of the AppCookieStickinessPolicy objects created with
      -- CreateAppCookieStickinessPolicy.
    , _rLBCookieStickinessPolicies :: [LBCookieStickinessPolicy]
      -- ^ A list of LBCookieStickinessPolicy objects created with
      -- CreateAppCookieStickinessPolicy.
    , _rOtherPolicies :: [Text]
      -- ^ A list of policy names other than the stickiness policies.
    } deriving (Show, Generic)

instance FromXML Policies where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Policies"

instance ToQuery Policies where
    toQuery = genericQuery def

-- | The PolicyAttribute data type. This data type contains a key/value pair
-- that defines properties of a specific policy.
data PolicyAttribute = PolicyAttribute
    { _pbAttributeName :: Maybe Text
      -- ^ The name of the attribute associated with the policy.
    , _pbAttributeValue :: Maybe Text
      -- ^ The value of the attribute associated with the policy.
    } deriving (Show, Generic)

instance ToQuery PolicyAttribute where
    toQuery = genericQuery def

-- | The PolicyAttributeDescription data type. This data type is used to
-- describe the attributes and values associated with a policy.
data PolicyAttributeDescription = PolicyAttributeDescription
    { _paeAttributeName :: Maybe Text
      -- ^ The name of the attribute associated with the policy.
    , _paeAttributeValue :: Maybe Text
      -- ^ The value of the attribute associated with the policy.
    } deriving (Show, Generic)

instance FromXML PolicyAttributeDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "PolicyAttributeDescription"

instance ToQuery PolicyAttributeDescription where
    toQuery = genericQuery def

-- | The PolicyAttributeTypeDescription data type. This data type is used to
-- describe values that are acceptable for the policy attribute.
data PolicyAttributeTypeDescription = PolicyAttributeTypeDescription
    { _pateDescription :: Maybe Text
      -- ^ A human-readable description of the attribute.
    , _pateAttributeName :: Maybe Text
      -- ^ The name of the attribute associated with the policy type.
    , _pateDefaultValue :: Maybe Text
      -- ^ The default value of the attribute, if applicable.
    , _pateCardinality :: Maybe Text
      -- ^ The cardinality of the attribute. Valid Values: ONE(1) : Single
      -- value required ZERO_OR_ONE(0..1) : Up to one value can be
      -- supplied ZERO_OR_MORE(0..*) : Optional. Multiple values are
      -- allowed ONE_OR_MORE(1..*0) : Required. Multiple values are
      -- allowed.
    , _pateAttributeType :: Maybe Text
      -- ^ The type of attribute. For example, Boolean, Integer, etc.
    } deriving (Show, Generic)

instance FromXML PolicyAttributeTypeDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "PolicyAttributeTypeDescription"

instance ToQuery PolicyAttributeTypeDescription where
    toQuery = genericQuery def

-- | The PolicyDescription data type.
data PolicyDescription = PolicyDescription
    { _pePolicyTypeName :: Maybe Text
      -- ^ The name of the policy type associated with the load balancer.
    , _pePolicyAttributeDescriptions :: [PolicyAttributeDescription]
      -- ^ A list of policy attribute description structures.
    , _pePolicyName :: Maybe Text
      -- ^ The name of the policy associated with the load balancer.
    } deriving (Show, Generic)

instance FromXML PolicyDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "PolicyDescription"

-- | The PolicyTypeDescription data type.
data PolicyTypeDescription = PolicyTypeDescription
    { _ptePolicyAttributeTypeDescriptions :: [PolicyAttributeTypeDescription]
      -- ^ The description of the policy attributes associated with the load
      -- balancer policies defined by the Elastic Load Balancing service.
    , _pteDescription :: Maybe Text
      -- ^ A human-readable description of the policy type.
    , _ptePolicyTypeName :: Maybe Text
      -- ^ The name of the policy type.
    } deriving (Show, Generic)

instance FromXML PolicyTypeDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "PolicyTypeDescription"

-- | The security group that you can use as part of your inbound rules for your
-- load balancer's back-end Amazon EC2 application instances. To only allow
-- traffic from load balancers, add a security group rule to your back end
-- instance that specifies this source security group as the inbound source.
data SourceSecurityGroup = SourceSecurityGroup
    { _ssgGroupName :: Maybe Text
      -- ^ Name of the source security group. Use this value for the
      -- --source-group parameter of the ec2-authorize command in the
      -- Amazon EC2 command line tool.
    , _ssgOwnerAlias :: Maybe Text
      -- ^ Owner of the source security group. Use this value for the
      -- --source-group-user parameter of the ec2-authorize command in the
      -- Amazon EC2 command line tool.
    } deriving (Show, Generic)

instance FromXML SourceSecurityGroup where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "SourceSecurityGroup"

instance ToQuery SourceSecurityGroup where
    toQuery = genericQuery def

-- | Metadata assigned to a load balancer consisting of key-value pair. For more
-- information, see Tagging in the Elastic Load Balancing Developer Guide.
data Tag = Tag
    { _tKey :: Text
      -- ^ The key of the tag.
    , _tValue :: Maybe Text
      -- ^ The value of the tag.
    } deriving (Show, Generic)

instance FromXML Tag where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Tag"

instance ToQuery Tag where
    toQuery = genericQuery def

-- | The descriptions of all the tags associated with load balancer.
data TagDescription = TagDescription
    { _teTags :: Maybe [Tag]
      -- ^ List of tags associated with the load balancer.
    , _teLoadBalancerName :: Maybe Text
      -- ^ The name of the load balancer.
    } deriving (Show, Generic)

instance FromXML TagDescription where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "TagDescription"

makeLenses ''ConnectionSettings
makeLenses ''CrossZoneLoadBalancing
makeLenses ''Instance
makeLenses ''TagKeyOnly
makeLenses ''AccessLog
makeLenses ''AppCookieStickinessPolicy
makeLenses ''BackendServerDescription
makeLenses ''ConnectionDraining
makeLenses ''HealthCheck
makeLenses ''InstanceState
makeLenses ''LBCookieStickinessPolicy
makeLenses ''Listener
makeLenses ''ListenerDescription
makeLenses ''LoadBalancerAttributes
makeLenses ''LoadBalancerDescription
makeLenses ''Policies
makeLenses ''PolicyAttribute
makeLenses ''PolicyAttributeDescription
makeLenses ''PolicyAttributeTypeDescription
makeLenses ''PolicyDescription
makeLenses ''PolicyTypeDescription
makeLenses ''SourceSecurityGroup
makeLenses ''Tag
makeLenses ''TagDescription
