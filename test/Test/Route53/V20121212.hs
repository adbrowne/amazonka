{-# LANGUAGE TemplateHaskell      #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

-- |
-- Module      : Test.Route53.V20121212
-- Copyright   : (c) 2013 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Test.Route53.V20121212 (tests) where

import qualified Data.Text                     as Text
import           Data.Text.Encoding
import           Network.AWS.Route53.V20121212
import           Test.Common

tests :: Test
tests = testVersion route53Version
    [ testGroup "XML Request Encoding"
        [ testGroup "Hosted Zones"
            [ testProperty "Create" (body :: Body CreateHostedZone)
            ]
        ]
    , testGroup "XML Response Parsing"
        [ testGroup "Hosted Zones"
            [ testProperty "Create" (res :: Res CreateHostedZoneResponse)
            , testProperty "Delete" (res :: Res DeleteHostedZoneResponse)
            , testProperty "Get"    (res :: Res GetHostedZoneResponse)
            , testProperty "List"   (res :: Res ListHostedZonesResponse)
            ]
        ]
    ]

instance ToJSON CallerReference where
    toJSON = String . decodeUtf8 . unCallerReference

instance ToJSON ChangeStatus where
    toJSON = String . Text.pack . show

$(deriveJSON
    [ ''DelegationSet
    , ''ChangeInfo
    , ''Config
    , ''HostedZone
    ])

$(deriveArbitrary
    [ ''DelegationSet
    , ''CallerReference
    , ''ChangeInfo
    , ''ChangeStatus
    , ''Config
    , ''HostedZone
    ])

$(deriveResponse "test/request/Route53/V20121212"
    [ ''CreateHostedZone
    ])

$(deriveResponse "test/response/Route53/V20121212"
    [ ''CreateHostedZoneResponse
    , ''DeleteHostedZoneResponse
    , ''GetHostedZoneResponse
    , ''ListHostedZonesResponse
    ])

 -- ''ChangeResourceRecordSetsResponse
 -- ''DeleteHealthCheckResponse
 -- ''GetChangeResponse
 -- ''ListHealthChecksResponse
 -- ''ListHostedZonesResponse
 -- ''ListResourceRecordSetsResponse