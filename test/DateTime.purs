module Test.DateTime where

import Prelude
import Control.Monad.Free (Free)
import Data.DateTime as DT
import Data.DateTime.Gen (genDateTime)
import Data.Enum (fromEnum)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import React.Basic.DOM.Textf as TF
import React.Basic.DOM.Textf.DateTime (formatDateTime)
import Test.QuickCheck (quickCheckGen, (===))
import Test.Unit (TestF, suite, test)



tests :: Free TestF Unit
tests = suite "format date-time" do
  checkDateTime "Year" (DT.date >>> DT.year >>> fromEnum >>> show) [TF.yyyy]
  checkDateTime "Month" (DT.date >>> DT.month >>> fromEnum >>> show) [TF.m]
  checkDateTime "Month full" (DT.date >>> DT.month >>> show) [TF.mmmm]
  checkDateTime "Day" (DT.date >>> DT.day >>> fromEnum >>> show) [TF.d]


checkDateTime :: String -> (DT.DateTime -> String) -> Array (DT.DateTime -> String) -> Free TestF Unit
checkDateTime name f fmt = test name do
  liftEffect $ quickCheckGen $ do
    dt <- genDateTime
    let expected = f dt
    pure $ expected === format fmt dt


format :: Array (DT.DateTime -> String) -> DT.DateTime -> String
format fmt =
  formatDateTime { format: Just fmt
                 , title: Nothing
                 , className: Nothing
                 , style: Nothing
                 }

