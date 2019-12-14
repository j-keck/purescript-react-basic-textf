module React.Basic.DOM.Textf.Integer where

import React.Basic.DOM.Textf.Props
import Data.Show (show)
import Prelude (($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (Fragment(..), IntProps)
import Unsafe.Coerce (unsafeCoerce)


type IntPropsRow = (CommonPropsRow)


int :: forall l r. Union l r IntPropsRow => Record l -> Int -> Fragment
int props i = let row = unsafeCoerce props
              in Int (lookupCommonProps row { }) i

int' :: Int -> Fragment
int' = int {}


packInt :: IntProps -> Int -> JSX
packInt props i =
  R.span $ mergeCommonProps props { children: [ R.text $ formatInt props i ] }


formatInt :: IntProps -> Int -> String
formatInt _ = show
