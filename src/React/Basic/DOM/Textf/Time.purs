module React.Basic.DOM.Textf.Time (time, packTime) where

import Data.DateTime as DT
import Data.Maybe (maybe)
import Data.Traversable (foldMap)
import Prelude (show, ($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (TimeProps, Fragment(..))
import React.Basic.DOM.Textf.Props (CommonPropsRow, lookupCommonProps, may, mergeCommonProps)
import Unsafe.Coerce (unsafeCoerce)


type TimePropsRow =
  ( format :: Array (DT.Time -> String)
  | CommonPropsRow
  )


time :: forall l r. Union l r TimePropsRow => Record l -> DT.Time -> Fragment
time props t = let row = unsafeCoerce props
               in Time (lookupCommonProps row
                        { format: may row.format }
                       ) t

packTime :: TimeProps -> DT.Time -> JSX
packTime props t =
  R.span $ mergeCommonProps props { children: [ R.text $ formatTime props t ] }

formatTime :: TimeProps -> DT.Time -> String
formatTime props t = maybe (show t) (foldMap (\fmt -> fmt t)) props.format
