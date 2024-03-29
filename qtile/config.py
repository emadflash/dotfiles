from typing import List  # noqa: F401

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in stack pane"),
    ##################################
    # Monad Tall
    ##################################
    Key([mod], "h", lazy.layout.grow()),
    Key([mod], "l", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "control"], "space", lazy.layout.flip()),
    # Move windows up or down in current stack
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack ",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack ",
    ),
    # Switch window focus to other pane(s) of stack
    Key(
        [mod],
        "Tab",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    # Swap panes of split stack
    Key([mod], "minus", lazy.layout.rotate(), desc="Swap panes of split stack"),
    # Toggle between split and unsplit sides of stack.
    # Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    # desc="Toggle between split and unsplit sides of stack"),
    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "equal", lazy.next_layout(), desc="Cycle layouts forwards"),
    Key([mod, "shift"], "equal", lazy.prev_layout(), desc="Cycle layouts backwords"),
    Key([mod, "shift"], "s", lazy.increase_ratio(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("dmenu_run -b"), desc="Run dmenu"),
]

##### NAMED-GROUPS ######
groups = [
    Group("MAIN"),
    Group("WEB"),
    Group("MAIL"),
    Group("ORG"),
    Group("Extra"),
]
group_names = [
    ("TERM", {"layout": "MonadTall"}),
    ("VIM", {"layout": "Max"}),
    ("TEST", {"layout": "MonadTall"}),
    ("ORG", {"layout": "MonadWide"}),
    ("CHAT", {"layout": "MonadWide"}),
    ("MAIL", {"layout": "MonadTall"}),
    ("WEB", {"layout": "MonadWide"}),
    ("MUS", {"layout": "MonadTall"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]
for i, (name, kwargs) in enumerate(group_names):
    keys.append(
        Key([mod], str(i + 1), lazy.group[name].toscreen())
    )  # Switch to another group
    keys.append(
        Key([mod, "shift"], str(i + 1), lazy.window.togroup(name))
    )  # Send current window to another group


########### code colors ##############
colorBlack = "#020202"  # Background
colorBlackAlt = "#1c1c1c"  # Black Xdefaults
colorGray = "#444444"  # Gray
colorGrayAlt = "#101010"  # Gray dark
colorGrayAlt2 = "#404040"
colorGrayAlt3 = "#252525"
colorWhite = "#a9a6af"  # Foreground
colorWhiteAlt = "#9d9d9d"  # White dark
colorWhiteAlt2 = "#b5b3b3"
colorWhiteAlt3 = "#707070"
colorMagenta = "#8e82a2"
colorBlue = "#44aacc"
colorBlueAlt = "#3955c4"
colorRed = "#f7a16e"
colorRedAlt = "#e0105f"
colorGreen = "#66ff66"
colorGreenAlt = "#558965"
colorGreenAlt2 = "#42a300"
colorBlueAlt2 = "#05d9e8"


init_layout_theme = {
    "border_width": 3,
    "margin": 0,
    "border_focus": colorGreenAlt2,
    "border_normal": colorGrayAlt3,
}

layouts = [
    layout.Max(**init_layout_theme, name="Max"),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(**init_layout_theme, name="MonadTall"),
    layout.MonadWide(**init_layout_theme, name="MonadWide"),
    # layout.RatioTile(),
    # layout.Tile(**init_layout_theme),
    layout.TreeTab(
        **init_layout_theme,
        name="TreeTab",
        bg_color=colorGrayAlt,
        active_bg=colorBlue,
        active_fg=colorBlack,
        inactive_bg=colorGrayAlt,
        inactive_fg=colorWhiteAlt3,
    ),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    background=colorBlack,
    foreground=colorWhite,
)
extension_defaults = widget_defaults.copy()

prompt = ": "

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Image(
                    filename="~/.config/qtile/icons/python.png",
                    mouse_callbacks={
                        "Button1": lambda qtile: qtile.cmd_spawn("dmenu_run")
                    },
                ),
                widget.Sep(
                    linewidth=0,
                    padding=6,
                    background=colorGrayAlt,
                ),
                widget.GroupBox(
                    font="terminus",
                    fontsize=12,
                    margin_y=3,
                    margin_x=0,
                    padding_y=5,
                    padding_x=5,
                    borderwidth=5,
                    border_color=colorWhiteAlt,
                    rounded=True,
                    active=colorBlueAlt2,
                    inactive=colorGray,
                    block_highlight_text_color=colorBlack,
                    highlight_color=colorBlue,
                    highlight_method="line",
                    background=colorGrayAlt,
                    foreground=colorBlack,
                    # this_current_screen_border = colors[3],
                    # this_screen_border = colors [4],
                    # other_current_screen_border = colors[0],
                    # other_screen_border = colors[0],
                ),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox(
                    text="\u25C0",
                    fontsize=65,
                    padding=-9,
                    background=colorBlack,
                    foreground=colorBlue,
                ),
                widget.BitcoinTicker(
                    currency="",
                    background=colorBlue,
                    foreground=colorBlack,
                ),
                widget.TextBox(
                    text="\u25C0",
                    fontsize=65,
                    padding=-9,
                    background=colorBlue,
                    foreground=colorBlack,
                ),
                widget.CPUGraph(
                    background=colorBlack,
                    graph_color=colorBlack,
                    fill_color=colorBlue,
                ),
                widget.Memory(),
                widget.TextBox(
                    text="\u25C0",
                    fontsize=65,
                    padding=-9,
                    background=colorBlack,
                    foreground=colorBlue,
                ),
                widget.Clock(
                    format="%m-%d %a %I:%M %p",
                    background=colorBlue,
                    foreground=colorBlack,
                ),
                widget.TextBox(
                    text="\u25C0",
                    fontsize=65,
                    padding=-9,
                    background=colorBlue,
                    foreground=colorBlack,
                ),
                widget.Volume(),
                widget.Wlan(
                    interface="wlan0",
                ),
                widget.Systray(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.client_new
def func(client):
    if client.name == "Mozilla Firefox":
        client.togroup("WEB")
    elif client.name == "Discord":
        client.togroup("CHAT")


# window manager name
wmname = "LG3D"
