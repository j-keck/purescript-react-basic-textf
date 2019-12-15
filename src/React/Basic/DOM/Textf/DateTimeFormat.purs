module React.Basic.DOM.Textf.DateTimeFormat
       ( class HasDate
       , getDate
       , class HasTime
       , getTime
       , yyyy
       , mm
       , dd
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


yyyy :: forall a. HasDate a => a -> String
yyyy = getDate >>> DT.year >>> fromEnum >>> show

mm :: forall a. HasDate a => a -> String
mm = getDate >>> DT.month >>> fromEnum >>> show >>> lpad

dd :: forall a. HasDate a => a -> String
dd = getDate >>> DT.day >>> fromEnum >>> show >>> lpad

hh :: forall a. HasTime a => a -> String
hh = getTime >>> DT.hour >>> fromEnum >>> show >>> lpad

mi :: forall a. HasTime a => a -> String
mi = getTime >>> DT.minute >>> fromEnum >>> show >>> lpad

ss :: forall a. HasTime a => a -> String
ss = getTime >>> DT.second >>> fromEnum >>> show >>> lpad

s :: forall a. String -> a -> String
s = const

lpad :: String -> String
lpad str | S.length str == 1 = "0" <> str
         | otherwise         = str

