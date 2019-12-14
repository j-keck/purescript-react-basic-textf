module Test.Num where

import Prelude
import Control.Monad.Free (Free)
import Data.Maybe (Maybe(..))
import React.Basic.DOM.Textf.Num (formatNum)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert as Assert

tests :: Free TestF Unit
tests = suite "format number" do
  test "precision" do
    Assert.equal "1.1" $ withPrecision 1 1.1234
    Assert.equal "1.6" $ withPrecision 1 1.5678
    Assert.equal "2"   $ withPrecision 0 1.6789


withPrecision :: Int -> Number -> String
withPrecision p = formatNum
                  { precision: Just p
                  , className: Nothing
                  , style: Nothing
                  , title: Nothing
                  }

