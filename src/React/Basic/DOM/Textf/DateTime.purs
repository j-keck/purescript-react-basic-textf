module React.Basic.DOM.Textf.DateTime where

import Data.DateTime as DT
import Data.Maybe (maybe)
import Data.Traversable (foldMap)
import Prelude (show, ($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (DateTimeProps, Fragment(..))
import React.Basic.DOM.Textf.Props (CommonPropsRow, lookupCommonProps, may, mergeCommonProps)
import Unsafe.Coerce (unsafeCoerce)


type DateTimePropsRow =
  ( format :: Array (DT.DateTime -> String)
  | CommonPropsRow
  )

dateTime :: forall l r. Union l r DateTimePropsRow => Record l -> DT.DateTime -> Fragment
dateTime props dt = let row = unsafeCoerce props
                    in DateTime (lookupCommonProps row
                                 { format : may row.format }
                                 ) dt


packDateTime :: DateTimeProps -> DT.DateTime -> JSX
packDateTime props dt =
   R.span $ mergeCommonProps props { children: [ R.text $ formatDateTime props dt ] }


formatDateTime :: DateTimeProps -> DT.DateTime -> String
formatDateTime props dt =
  maybe (show dt) (foldMap (\fmt -> fmt dt)) props.format
