module React.Basic.DOM.Textf.Fragment where

import Data.DateTime as DT
import Data.Maybe (Maybe)
import React.Basic as React.Basic
import React.Basic.DOM as R


data Fragment =
    Jsx React.Basic.JSX
  | Text TextProps String
  | Int IntProps Int
  | Num NumProps Number
  | Time TimeProps DT.Time
  | Date DateProps DT.Date
  | DateTime DateTimeProps DT.DateTime

type CommonProps = (title :: Maybe String, className :: Maybe String, style :: Maybe R.CSS)

type TextProps = { | CommonProps }

type IntProps = { | CommonProps }

type NumProps =
  { precision :: Maybe Int
  | CommonProps
  }

type TimeProps =
  { format :: Maybe (Array (DT.Time -> String))
  | CommonProps
  }

type DateProps =
  { format :: Maybe (Array (DT.Date -> String))
  | CommonProps
  }

type DateTimeProps =
  { format :: Maybe (Array (DT.DateTime -> String))
  | CommonProps
  }

