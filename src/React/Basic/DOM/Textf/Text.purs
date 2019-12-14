module React.Basic.DOM.Textf.Text where

import Prelude (($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (Fragment(..), TextProps)
import React.Basic.DOM.Textf.Props (CommonPropsRow, lookupCommonProps, mergeCommonProps)
import Unsafe.Coerce (unsafeCoerce)



type TextPropsRow = CommonPropsRow

text :: forall l r. Union l r TextPropsRow => Record l -> String -> Fragment
text props s = let row = unsafeCoerce props
               in Text (lookupCommonProps row { }) s

text' :: String -> Fragment
text' = text {}

packText :: TextProps -> String -> JSX
packText props s =
  R.span $ mergeCommonProps props { children: [ R.text s ] }

