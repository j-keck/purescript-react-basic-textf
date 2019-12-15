module Test.DateTime where

import Prelude
import Control.Monad.Free (Free)
import Data.DateTime as DT
import Data.DateTime.Gen (genDateTime)
import Data.Enum (fromEnum)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import React.Basic.DOM.Textf (yyyy)
import React.Basic.DOM.Textf.DateTime (formatDateTime)
import Test.QuickCheck (quickCheckGen, (===))
import Test.Unit (TestF, suite, test)



tests :: Free TestF Unit
tests = suite "format date-time" do
  test "Year" do
    liftEffect $ quickCheckGen $ do
      dt <- genDateTime
      let expected = (DT.date >>> DT.year >>> fromEnum >>> show) dt
      pure $ expected === format [yyyy] dt


format :: Array (DT.DateTime -> String) -> DT.DateTime -> String
format fmt =
  formatDateTime { format: Just fmt
                 , title: Nothing
                 , className: Nothing
                 , style: Nothing
                 }

