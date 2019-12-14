module React.Basic.DOM.Textf.Num where

import Data.Maybe (maybe)
import Data.Ord (clamp)
import Data.Show (show)
import Prelude (($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (Fragment(..), NumProps)
import React.Basic.DOM.Textf.Props
import Unsafe.Coerce (unsafeCoerce)



type NumPropsRow = (precision :: Int | CommonPropsRow)

num :: forall l r. Union l r NumPropsRow => Record l -> Number -> Fragment
num props n = let row = unsafeCoerce props
            in Num (lookupCommonProps row { precision: may row.precision }) n

num' :: Number -> Fragment
num' = num {}


packNum :: NumProps -> Number -> JSX
packNum props n =
  R.span $ mergeCommonProps props { children: [ R.text $ formatNum props n ] }


-- | the precision are clamped between 0 and 20 see:
-- | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed
formatNum :: NumProps -> Number -> String
formatNum props n = maybe (show n) (\p -> toFixed (clamp 0 20 p) n) props.precision

foreign import toFixed :: Int -> Number -> String
