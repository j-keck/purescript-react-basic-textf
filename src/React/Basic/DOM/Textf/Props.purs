module React.Basic.DOM.Textf.Props where

import Record
import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Foreign (isUndefined)
import Foreign as F
import React.Basic.DOM as R
--import Type.Row (type (+))



type CommonPropsRow = ( title :: String, className :: String, style :: R.CSS )


-- FIXME: what type has this function?!
-- lookupCommonProps :: forall r. Record CommonPropsRow -> Record r ->  ( CommonProps + r )
lookupCommonProps cp r =
  let cp' = { title: may cp.title
           , className: may cp.className
           , style: may cp.style
           }
  in union cp' r


-- FIXME: don't use empty string if a property is missing - build the record content only with the given fields
mergeCommonProps cp r =
  union { title: fold cp.title
        , className: fold cp.className
        , style: fold cp.style
        } r


-- |
may :: forall a. a -> Maybe a
may a = let f = F.unsafeToForeign a
        in if isUndefined f then Nothing else Just (F.unsafeFromForeign f)

