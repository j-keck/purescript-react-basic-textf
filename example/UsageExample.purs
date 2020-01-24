module UsageExample where

import Data.DateTime (DateTime)
import Data.Maybe (maybe)
import Data.Monoid ((<>))
import Effect (Effect)
import Effect.Exception (throw)
import Effect.Now (nowDateTime)
import Prelude (class Functor, Unit, map, pure, ($), (>>=), (>>>), bind)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Textf as TF
import Web.HTML (window)
import Web.HTML.HTMLDocument (body)
import Web.HTML.HTMLElement (toElement)
import Web.HTML.Window (document)


main :: Effect Unit
main = do
  dt <- nowDateTime
  mount $ example dt

example :: DateTime -> JSX
example dt = TF.textf
  [ TF.text { title: "Tooltip text"
            , style: TF.textUnderline <> R.css { color: "red" }
            } "This is a red, underlined text. "
  , TF.jsx $ R.br {}
  , TF.text' "This is a rounded Number: "
  , TF.num { precision: 2 } 49.12345679
  , TF.text' "."
  , TF.jsx $ R.br {}
  , TF.text' "This is a Date: "
  , TF.dateTime { format: [ TF.dd, TF.s ", ", TF.mmmm, TF.s " ", TF.yyyy ] } dt
  ]

mount :: JSX -> Effect Unit
mount jsx = do
  lookupBody' >>= R.render jsx
  where lookupBody = toElement <$$> (window >>= document >>= body)
        lookupBody' = lookupBody >>= maybe (throw $ "body not found") pure


mapmap :: forall a b f1 f2. Functor f1 => Functor f2 => (a -> b) -> f1 (f2 a) -> f1 (f2 b)
mapmap = map >>> map
infix 4 mapmap as <$$>
