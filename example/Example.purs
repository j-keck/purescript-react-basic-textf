module Example where

import Data.DateTime as DT
import Data.Int (toNumber)
import Data.Maybe (maybe)
import Effect (Effect)
import Effect.Exception (throw)
import Effect.Now (nowDateTime)
import Prelude (class Functor, Unit, map, pure, ($), (*), (>>=), (>>>), bind)
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
  let a = 3
      b = 43.1234567
      header = TF.text { style: R.css
                           { display: "block"
                           , fontSize: "xx-large"
                           , margin: "20px 0px 5px 0px"
                           }
                       }
      jsx = TF.textf
            [ header "Text / Numbers"
            , TF.text { title: "very simple!" } "a simple example: "
            , TF.int' a
            , TF.text' " * "
            , TF.num { precision: 2} b
            , TF.text' " = "
            , TF.num { precision: 2
                     , style: R.css { fontWeight: "bold" }
                     } (toNumber a * b)
            , TF.text' "."
              -- ------------------------------------------
            , header "Time"
            , TF.text' "Current time: "
            , TF.time { format: [TF.hh, TF.s ":", TF.mi, TF.s ":", TF.ss]
                      , title: "Format: hh:mi:ss"
                      , style: R.css { fontFamily: "monospace" }
                      } $ DT.time dt
              -- ------------------------------------------
            , header "Date"
            , TF.text' "Current date: "
            , TF.date { format: [TF.dd, TF.s ".", TF.mm, TF.s ".", TF.yyyy]
                      , title: "Format: dd.mm.yyyy"
                      , style: R.css { border: "1px solid black" }
                      } $ DT.date dt

              -- ------------------------------------------
            , header "DateTime"
            , TF.dateTime { format: [ TF.s "Day: ", TF.dd, TF.s ", Month: ", TF.mm
                                    , TF.s ", Hour: ", TF.hh, TF.s ", Seconds: ", TF.ss
                                    ]
                          } dt
            ]

  mount jsx


mount :: JSX -> Effect Unit
mount jsx = do
  lookupBody' >>= R.render jsx
  where lookupBody = toElement <$$> (window >>= document >>= body)
        lookupBody' = lookupBody >>= maybe (throw $ "body not found") pure


mapmap :: forall a b f1 f2. Functor f1 => Functor f2 => (a -> b) -> f1 (f2 a) -> f1 (f2 b)
mapmap = map >>> map
infix 4 mapmap as <$$>
