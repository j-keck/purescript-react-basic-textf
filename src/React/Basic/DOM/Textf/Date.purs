module React.Basic.DOM.Textf.Date where

import Data.DateTime as DT
import Data.Maybe (maybe)
import Data.Traversable (foldMap)
import Prelude (show, ($))
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf.Fragment (DateProps, Fragment(..))
import React.Basic.DOM.Textf.Props (CommonPropsRow, lookupCommonProps, may, mergeCommonProps)
import Unsafe.Coerce (unsafeCoerce)


type DatePropsRow =
  ( format :: Array (DT.Date -> String)
  | CommonPropsRow
  )

date :: forall l r. Union l r DatePropsRow => Record l -> DT.Date -> Fragment
date props d = let row = unsafeCoerce props
               in Date (lookupCommonProps row
                        { format: may row.format }
                       ) d


packDate :: DateProps -> DT.Date -> JSX
packDate props d =
  R.span $ mergeCommonProps props { children: [ R.text $ formatDate props d ] }


formatDate :: DateProps -> DT.Date -> String
formatDate props t = maybe (show t) (foldMap (\fmt -> fmt t)) props.format
