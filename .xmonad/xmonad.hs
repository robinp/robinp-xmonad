--
-- An example, simple ~/.xmonad/xmonad.hs file.
-- It overrides a few basic settings, reusing all the other defaults.
--
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ dc
    { borderWidth        = 2
    , terminal           = "gnome-terminal"
    , normalBorderColor  = "#eeeecc"
    , focusedBorderColor = "#cd8b00" 
    , manageHook = manageDocks <+> manageHook dc
    , layoutHook = myLayout
    , logHook = dynamicLogWithPP xmobarPP
                  { ppOutput  = hPutStrLn xmproc
                  , ppTitle   = xmobarColor "green" "" . shorten 50
                  }
    } `additionalKeys`
    [ (winKey xK_l, spawn "xscreensaver-command -lock") ]
    where dc = defaultConfig
          winKey = (,) mod4Mask
          myLayout = withMirror tall `noStrutsLnoBordersR` (fullscreenFull Full)
            where tall = Tall 1 (3/100) (1/2)
                  withMirror x = x ||| Mirror x
                  noStrutsLnoBordersR l r = avoidStruts l ||| noBorders r
