module React.Basic.DOM.Textf.DateTimeFormat
       ( class HasDate
       , getDate
       , class HasTime
       , getTime
       , yyyy
       , m
       , mm
       , mmm
       , mmmm
       , d
       , dd
       , ddd
       , dddd
       , hh
       , mi
       , ss
       , s
       ) where

import Data.Boolean (otherwise)
import Data.DateTime as DT
import Data.Enum (fromEnum)
import Data.Eq ((==))
import Data.Function (const, identity, (>>>))
import Data.Monoid ((<>))
import Data.Show (show)
import Data.String as S

class HasDate a where
  getDate :: a -> DT.Date
instance dateHasDate :: HasDate DT.Date where
  getDate = identity
instance dateTimeHasDate :: HasDate DT.DateTime where
  getDate = DT.date

class HasTime a where
  getTime :: a -> DT.Time
instance timeHasTime :: HasTime DT.Time where
  getTime = identity
instance dateTimeHasTime :: HasTime DT.DateTime where
  getTime = DT.time

-- | Jear full - like 2020
yyyy :: forall a. HasDate a => a -> String
yyyy = getDate >>> DT.year >>> fromEnum >>> show


-- | Month with digits
m :: forall a. HasDate a => a -> String
m = getDate >>> DT.month >>> fromEnum >>> show


-- | Month with two digits
mm :: forall a. HasDate a => a -> String
mm = getDate >>> DT.month >>> fromEnum >>> show >>> lpad


-- | Month short text - like Jan, Feb, ...
mmm :: forall a. HasDate a => a -> String
mmm = getDate >>> DT.month >>> monthShort
  where monthShort = case _ of
          DT.January -> "Jan"
          DT.February -> "Feb"
          DT.March -> "Mar"
          DT.April -> "Apr"
          DT.May -> "May"
          DT.June -> "Jun"
          DT.July -> "Jul"
          DT.August -> "Aug"
          DT.September -> "Sep"
          DT.October -> "Oct"
          DT.November -> "Nov"
          DT.December -> "Dec"


-- | Month full text - like January, Februrary, ...
mmmm :: forall a. HasDate a => a -> String
mmmm = getDate >>> DT.month >>> show


-- | Day of month - with digits
d :: forall a. HasDate a => a -> String
d = getDate >>> DT.day >>> fromEnum >>> show


-- | Day of month - two digits
dd :: forall a. HasDate a => a -> String
dd = getDate >>> DT.day >>> fromEnum >>> show >>> lpad


-- | Day of month short text - like Mon, Tue ...
ddd :: forall a. HasDate a => a -> String
ddd = getDate >>> DT.weekday >>> dayShort
  where dayShort = case _ of
          DT.Monday -> "Mon"
          DT.Tuesday -> "Tue"
          DT.Wednesday -> "Wed"
          DT.Thursday -> "Thu"
          DT.Friday -> "Fri"
          DT.Saturday -> "Sat"
          DT.Sunday -> "Sun"

-- | Day of month full text - like Monday, Tuesday, ...
dddd :: forall a. HasDate a => a -> String
dddd = getDate >>> DT.weekday >>> show


-- | Hours with two digits - in 24h format
hh :: forall a. HasTime a => a -> String
hh = getTime >>> DT.hour >>> fromEnum >>> show >>> lpad


-- | Minutes with two digits
mi :: forall a. HasTime a => a -> String
mi = getTime >>> DT.minute >>> fromEnum >>> show >>> lpad


-- | Seconds with two digits
ss :: forall a. HasTime a => a -> String
ss = getTime >>> DT.second >>> fromEnum >>> show >>> lpad


-- | Separator
s :: forall a. String -> a -> String
s = const


lpad :: String -> String
lpad str | S.length str == 1 = "0" <> str
         | otherwise         = str
