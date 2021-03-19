import XMonad hiding ((|||))
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import System.IO
import System.Exit
import XMonad.Actions.GroupNavigation
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.PhysicalScreens
import Data.Default


--Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName


-- Utils
import XMonad.Util.SpawnOnce
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import Data.List (isPrefixOf, findIndex)
import System.Directory (getHomeDirectory)
import System.Posix.Unistd (getSystemID, SystemID(..))
import Text.Printf
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP, additionalMouseBindings)
import XMonad.Util.WorkspaceCompare
import Graphics.X11.ExtraTypes.XF86


--- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Magnifier
import XMonad.Layout.Tabbed
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Grid
import XMonad.Layout.SimpleDecoration (shrinkText)

--- Layout modifiers
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Gaps
import XMonad.Layout.LayoutModifier


import XMonad.Actions.ShowText
import XMonad.Actions.CycleWorkspaceByScreen
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote


--Prompt
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Window

myWorkspaces :: [String]
myWorkspaces =  ["main", "vim", "test", "org", "chat", "mail", "web", "Rev", "Recon"]


mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True


myXPConfig :: XPConfig
myXPConfig = def
      { font                = "xft:Ubuntu Mono:regular:size=14"
      , bgColor             = "black"
      , fgColor             = "grey"
      , bgHLight            = "orange"
      , fgHLight            = "black"
      , promptBorderWidth   = 0
      , height              = 23
      , historySize         = 256
      , historyFilter       = id
      }


myTabConfig = def { activeColor = "#073642"
                  , inactiveColor = "#586e75"
                  , activeBorderColor = "#073642"
                  , inactiveBorderColor = "#586e75"
                  , activeTextColor = "#93a1a1"
                  , inactiveTextColor = "grey"
                  , fontName = "xft:terminus:size=9:antialias=true"
                  }

--layout
myLayout = avoidStruts $ tiled ||| noBorders Full ||| noBorders (tabbed shrinkText myTabConfig)

  where
     tiled = mySpacing 2 $ ResizableTall nmaster delta ratio []
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

--scratchpad
myScratchPads = [ NS "spvifm" "alacritty -t vifm -e vifm -c only" (title =? "vifm") managePad
                ]

    where
    managePad = customFloating $ W.RationalRect l t w h
                 where
	             h = 0.7
	             w = 0.64
		     t = (1-h)/2
	      	     l = (1-w)/2
    
    managePad1 = customFloating $ W.RationalRect l t w h
                 where
	             h = 0.7
	             w = 0.7
		     t = (1-h)/2
	      	     l = (1-w)/2


manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
	where

	    h = 0.7
	    w = 0.64
	    t = (1-h)/2
	    l = (1-w)/2



myManageHook = composeAll [ isFullscreen --> doFullFloat
			   ,title =? "Mozilla Firefox" --> doShift ( myWorkspaces !! 6 )
			   ,title =? "File Transfer*"  --> doFloat
			   ,title =? "firefox"  --> doShift ( myWorkspaces !! 7 )
			   ,className=? "nano*"  --> doCenterFloat
			   ,role      =? "pop-up"  --> doCenterFloat
                          ] <+> (namedScratchpadManageHook myScratchPads) 
			  where role = stringProperty "WM_WINDOW_ROLE"

--placement floating windows
myPlacement = withGaps (16,0,16,0) (smart (0.5,0.5))



myStartupHook = do
	  setWMName "LG3D"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask, xK_Return)  , spawn $ "alacritty")
    , ((modm, xK_Return)		, dwmpromote)
    , ((modm, xK_j)			, windows W.focusDown)
    , ((modm, xK_k)			, windows W.focusUp)
    , ((modm .|. shiftMask, xK_k)	, windows W.swapUp)
    , ((modm .|. shiftMask, xK_j)	, windows W.swapDown)
    , ((modm, xK_h)			, sendMessage Shrink)
    , ((modm, xK_l)			, sendMessage Expand)
    , ((modm, xK_e)			, withFocused $ windows . W.sink)
    , ((modm, xK_i)			, sendMessage (IncMasterN 1))
    , ((modm, xK_d)			, sendMessage (IncMasterN (-1)))
    , ((modm, xK_space)			, sendMessage NextLayout)
    , ((modm, xK_b)			, toggleWS' ["NSP"])
    , ((modm, xK_Tab)			, nextMatch Forward (return True))
    , ((modm, xK_grave)          	, moveTo Next NonEmptyWS)
    , ((modm, xK_p)			, shellPrompt myXPConfig)
    , ((modm, xK_u)			, windowPrompt myXPConfig Goto allWindows)
    , ((modm .|. shiftMask, xK_u)	, windowPrompt myXPConfig Bring allWindows)
    , ((modm, xK_n)			, namedScratchpadAction myScratchPads "spvifm")
    , ((modm, xK_Print )		, spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1 -e 'mv $f ~/Pictures/screenshot/'")
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    ]
    ++
      [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


main :: IO()
main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , keys = myKeys
        --, manageHook = placeHook myPlacement <+> manageDocks <+> myManageHook
        , manageHook = manageDocks <+> myManageHook
        , layoutHook =  myLayout
        , handleEventHook = handleEventHook def <+> docksEventHook <+> handleTimerEvent
	, startupHook = myStartupHook
	, logHook = dynamicLogWithPP $ defaultPP { ppOutput = hPutStrLn xmproc, ppOrder = \(ws:_:t:_) -> [ws,t] }
	, workspaces = myWorkspaces
        , terminal = "alacritty"
	, borderWidth = 2
        , normalBorderColor = "#181b20"
        , focusedBorderColor = "grey"
        }
