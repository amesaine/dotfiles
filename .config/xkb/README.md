KCX Qwerty - Keyboard-Centric Experience 
========================================

QWERTY variant for a keyboard-centric and mouseless desktop experience.

KCX Qwerty is a variant made to streamline keyboard shortcut usage with laptops, touch typists, 
vim users, and terminal hobbits in mind. Additional layouts are provided to take advantage 
of keyboard layout switching. 

Layouts
-------

### KCX (Qwerty)
![KCX (Qwerty) Layout Picture](https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/kcx-qwerty.webp)

### KCX (Homerow Symbols)
![KCX (Homerow Symbols) Layout Picture](https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/kcx-homerow-symbols.webp)

> [!NOTE]
> Other keys are omitted from the picture, but all keys have been swapped with their counterparts. (e.g. Arrow keys become HJKL)

Quickstart
----------
### Installation
```
git clone -n --depth=1 --filter=tree:0 https://github.com/jnzigg/dotfiles
cd dotfiles
git sparse-checkout set --no-cone .config/xkb
git checkout
mkdir -p $HOME/.config/xkb/rules
mkdir -p $HOME/.config/xkb/symbols
cp -r -S .bak .config/xkb/rules/* $HOME/.config/xkb/rules/
cp -r -S .bak .config/xkb/symbols/* $HOME/.config/xkb/symbols/
```
> [!NOTE]
> This will overwrite existing destination files. Your original files such as *evdev.xml*
will be saved as *evdev.xml.bak*

### Sway
```
input type:keyboard {
    xkb_layout kcx(qwerty),kcx(homerow_sym)
}
```
```
bindsym Control+semicolon exec swaymsg input type:keyboard xkb_switch_layout next
```

You can use my [bash script][sway-kbfb] if you want to change focused window border colors when switching layouts.

```
bindsym Control+semicolon exec sway-kbfb
```

### GNOME

1. Search for *KCX (Qwerty)* and *KCX (Homerow Symbols)* in `gnome-control-center > Keyboard > Input Sources`
2. Set the layout switch shortcut under `...Keyboard > View and Customize Shortcuts > Typing`
with my recommended *Control + semicolon* keybind.
3. Instead of using the full layout, you can toggle individual options in
`gnome-tweaks > Keyboard & Mouse > Additional Layout Options > KCX Options`

FAQ
---

### Why QWERTY instead of this other superior layout?

> Qwerty is the standard. Learning an obscure layout for speed/ergonomics is unnecessary and inconvenient. 
On average, I type 110-135wpm which is more than enough (i flexed on ya btw). My style of touch typing
also maximizes ergonomics. (I'll probably make a repo/wiki on this)

### Where's Right Shift?

> I never used it so it went bye-bye.

### Where's Right Alt? I need AltGr for foreign characters.

> I do not use it so it was replaced with Escape. I suggest replacing Right Control with Right Alt instead
of Caps Lock in QWERTY mode if it is essential.

### Do I need a special keyboard for this?

> Any standard keyboard will do. Flatter keyboards on laptops are better solely because it is easier
to press the relocated Escape with the right thumb. I find that bulky spacebars often get in the way.

### Copy pasting in a shell doesn't work properly only when using this config.

> You might be doing `Control+Shift+[something]`. Instead, do `Shift+Control+[something]`.
>
> In KCX (Homerow Symbols), Shift is replaced with *[ s, S ]*. Somehow, this takes effect
when combined with the *Control modifier* even when the layout isn't active. What's happening
is `Control+Shift` becomes `Control+S` which sends a XOFF signal, pausing stdin. If you find
yourself in this predicament, `Control+q` will send XON and unfreeze the shell.
>
> I haven't figured out how to configure this properly so you can do one of the following to eliminate this altogether:
> - Inside `$HOME/xkb/symbols/kcxvar/homerow_sym`, delete `replace key <LFSH> { [ s, S ] };`
> - Follow this [solution][xoff/xonn] if you want to still swap the keys.

### Can I still use this with another layout? (e.g. Dvorak, Colemak)
> Yes. The remaps target actual key placement, not the represented symbols. Inside `$HOME/xkb/symbols/kcx`,
> ```
> include "us(basic)" // replace this
> include "us(dvorak)" // with this
> ```
> Note that the xkb_option names will not automatically reflect the actual symbols they are remapping. It assumes
> Qwerty as the base layout.


Resources
---------

[XKB Configuration Files Documentation](https://www.charvolant.org/doug/xkb/html/node5.html#SECTION00054000000000000000)

[Libxkbcommon commit: Allow for custom rulesets through include files](https://github.com/xkbcommon/libxkbcommon/pull/108/commits/bc4a691cb9f45c3309c78c997e00212f0978d082)

[Setting up ~/.config/xkb/](https://who-t.blogspot.com/2020/02/user-specific-xkb-configuration-part-1.html)

[Creating evdev.xml](https://who-t.blogspot.com/2020/07/user-specific-xkb-configuration-part-2.html)

[Extending system layouts with custom variants](https://who-t.blogspot.com/2020/08/user-specific-xkb-configuration-part-3.html)

[Youtube video where I discovered the blog posts from](https://www.youtube.com/watch?v=utqpa_8SXkA)

Acknowledgement
---------------

### Keyboard Layout Pictures
- Created with [keyboard-layout-editor.com][keyboard-layout-editor]. JSON for all layouts are available in
[assets][assets].
- Upscaled with AI. (Because SVG export doesn't work properly and the project is unmaintained)

[sway-kbfb]: https://github.com/jnzigg/dotfiles/blob/master/bin/sway-kbfb

[xoff/xonn]: https://unix.stackexchange.com/a/12108/593070
[gnome-add-input-source]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-add-input-source.webp
[gnome-switch-layout-shortcut]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-switch-layout-shortcut.webp
[gnome-tweaks]: https://github.com/jnzigg/dotfiles/blob/master/.config/xkb/assets/gnome-tweaks.webp
[keyboard-layout-editor]: http://www.keyboard-layout-editor.com/
[assets]: https://github.com/jnzigg/dotfiles/tree/master/.config/xkb/assets
