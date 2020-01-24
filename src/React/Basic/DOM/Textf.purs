module React.Basic.DOM.Textf
       ( textf
       , textf'
       , module React.Basic.DOM.Textf.Text
       , module React.Basic.DOM.Textf.Integer
       , module React.Basic.DOM.Textf.Num
       , module React.Basic.DOM.Textf.Time
       , module React.Basic.DOM.Textf.Date
       , module React.Basic.DOM.Textf.DateTime
       , module React.Basic.DOM.Textf.DateTimeFormat
       , module React.Basic.DOM.Textf.Styles.Text
       , module React.Basic.DOM.Textf.Styles.Font
       ) where


import Data.Function ((<<<))
import Data.Functor (map)
import React.Basic as React
import React.Basic.DOM.Textf.Fragment (Fragment(..))
import React.Basic.DOM.Textf.Text (text, text', packText)
import React.Basic.DOM.Textf.Integer (int, int', packInt)
import React.Basic.DOM.Textf.Num (num, num', packNum)
import React.Basic.DOM.Textf.Time (time, packTime)
import React.Basic.DOM.Textf.Date (date, packDate)
import React.Basic.DOM.Textf.DateTime (dateTime, packDateTime)
import React.Basic.DOM.Textf.DateTimeFormat (yyyy, m, mm, mmm, mmmm, d, dd, ddd, dddd, hh, mi, ss, s)
import React.Basic.DOM.Textf.Styles.Text
import React.Basic.DOM.Textf.Styles.Font


-- | formats the given fragments
textf :: Array Fragment -> React.JSX
textf = React.fragment <<< map textf'


-- | format the given fragment
textf' :: Fragment -> React.JSX
textf' = case _ of
  Text props s -> packText props s
  Int props i -> packInt props i
  Num props n -> packNum props n
  Time props t -> packTime props t
  Date props d -> packDate props d
  DateTime props dt -> packDateTime props dt

