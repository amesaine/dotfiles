KCX Qwerty - Keyboard-Centric Experience 
========================================

QWERTY variant for a keyboard-centric and mouseless desktop experience.

KCX Qwerty is a variant made with touch typists, vim users, and terminal
hobbits in mind. It retains the placement of alphanumeric keys and relocates modifier
keys and super keys with sane defaults. Additional layouts are included to take
advantage of keyboard layout switching. 

Layouts
-------

### KCX (Qwerty)
![KCX (Qwerty) Layout Picture](https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/kcx-qwerty.webp)

### KCX (Homerow Symbols)
![KCX (Homerow Symbols) Layout Picture](https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/kcx-homerow-symbols.webp)

Quickstart
----------
```
git clone -n --depth=1 --filter=tree:0 https://github.com/jnzigg/dotfiles
cd dotfiles
git sparse-checkout set --no-cone .config/xkb
git checkout
mkdir -p $HOME/.config/xkb/rules
mkdir -p $HOME/.config/xkb/symbols
cp -ir .config/xkb/rules/* $HOME/.config/xkb/rules/
cp -ir .config/xkb/symbols/* $HOME/.config/xkb/symbols/
```
> Note: You will be prompted should there be any overwrites.

### Sway
```
input type:keyboard {
    xkb_layout kcx(qwerty),kcx(homerow_sym)
}
bindsym Control+semicolon exec swaymsg input type:keyboard xkb_switch_layout next
```

You can use my [bash script][sway-kbfb] if you want to change window border colors when switching

```
bindsym Control+semicolon exec sway-kbfb
```

### GNOME

#### Using the layouts

Add the keyboard layouts in **gnome-control-center > Keyboard > Input Sources**

![Screenshot of adding input sources in gnome-control-center][gnome-add-input-source]

Then set the layout switching shortcut under **...Input Sources > View and Customize Shortcuts > Typing**
with the recommended *Control + semicolon* keybind.

![Screenshot of setting layout switching shortcut]

#### Setting individual xkb options

Besides editing the configuration files, the layouts' options can be toggled in
**gnome-tweaks > Keyboard & Mouse > Additional Layout Options**

![Screenshot of adding input sources in gnome-tweaks][gnome-switch-layout-shortcut]


Resources
---------
[XKB Configuration Files Documentation](https://www.charvolant.org/doug/xkb/html/node5.html#SECTION00054000000000000000)

[Libxkbcommon commit: Allow for custom rulesets through include files](https://github.com/xkbcommon/libxkbcommon/pull/108/commits/bc4a691cb9f45c3309c78c997e00212f0978d082)

[Setting up ~/.config/xkb/](https://who-t.blogspot.com/2020/02/user-specific-xkb-configuration-part-1.html)

[Creating evdev.xml](https://who-t.blogspot.com/2020/07/user-specific-xkb-configuration-part-2.html)

[Extending system layouts with custom variants](https://who-t.blogspot.com/2020/08/user-specific-xkb-configuration-part-3.html)

[Youtube video where I discovered the blog posts from](https://www.youtube.com/watch?v=utqpa_8SXkA)

[sway-kbfb]: https://github.com/jnzigg/dotfiles/blob/master/bin/sway-kbfb
[gnome-add-input-source]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-add-input-source.webp
[gnome-switch-layout-shortcut]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-switch-layout-shortcut.webp
[gnome-tweaks]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-tweaks.webp
