module Test.Main where

import Prelude
import Effect (Effect)
import Test.Num as Num
import Test.Unit.Main (runTest)


main :: Effect Unit
main = runTest do
  Num.tests
