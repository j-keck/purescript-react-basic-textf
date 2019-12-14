module React.Basic.DOM.Textf
       ( textf
       , textf'
       , module React.Basic.DOM.Textf.Text
       , module React.Basic.DOM.Textf.Integer
       , module React.Basic.DOM.Textf.Num
       ) where


import Data.Function ((<<<))
import Data.Functor (map)
import React.Basic as React
import React.Basic.DOM.Textf.Fragment (Fragment(..))
import React.Basic.DOM.Textf.Text (text, text', packText)
import React.Basic.DOM.Textf.Integer (int, int', packInt)
import React.Basic.DOM.Textf.Num (num, num', packNum)


-- | formats the given fragments
textf :: Array Fragment -> React.JSX
textf = React.fragment <<< map textf'


-- | format the given fragment
textf' :: Fragment -> React.JSX
textf' = case _ of
  Text props s -> packText props s
  Int props i -> packInt props i
  Num props n -> packNum props n
