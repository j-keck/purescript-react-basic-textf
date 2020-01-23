module React.Basic.DOM.Textf.Styles.Font where

import React.Basic.DOM as R


fontBold :: R.CSS
fontBold = R.css { fontWeight: "bold" }

fontBolder :: R.CSS
fontBolder = R.css { fontWeight: "bolder" }

fontLighter :: R.CSS
fontLighter = R.css { fontWeight: "lighter" }

fontItalic :: R.CSS
fontItalic = R.css { fontStyle: "italic" }

fontSize :: String -> R.CSS
fontSize s = R.css { fontSize: s }
