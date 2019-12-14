module React.Basic.DOM.Textf.Fragment where

import Data.Maybe (Maybe)
import React.Basic.DOM as R

data Fragment =
    Text TextProps String
  | Int IntProps Int
  | Num NumProps Number

type CommonProps = (title :: Maybe String, className :: Maybe String, style :: Maybe R.CSS)

type TextProps = { | CommonProps }

type IntProps = { | CommonProps }

type NumProps =
  { precision :: Maybe Int
  | CommonProps
  }
