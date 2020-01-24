module React.Basic.DOM.Textf.Jsx where

import React.Basic as React.Basic
import React.Basic.DOM.Textf.Fragment (Fragment(..))

-- | simple wrapper to include `React.Basic.DOM` elements
jsx :: React.Basic.JSX -> Fragment
jsx = Jsx
