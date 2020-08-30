{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code Retina";
      bold_font = "Fira Code Bold";
      italic_font = "Fira Code Light";
      bold_italic_font = "Fira Code Light";

      enable_audio_bell = "no";
      visual_bell_dueration = "0.5";
    };
  };

  programs.readline = {
    enable = true;

    bindings = {
      # works in most terminals: xterm, gnome-terminal, terminator, st, sakura, termit, …
      "\\e[1;5C" = "forward-word";
      "\\e[1;5D" = "backward-word";

      # urxvt
      "\\eOc" = "forward-word";
      "\\eOd" = "backward-word";

      ### ctrl+delete
      "\\e[3;5~" = "kill-word";
      # in this case, st misbehaves (even with tmux)
      "\\e[M" = "kill-word";
      # and of course, urxvt must be always special
      "\\e[3^" = "kill-word";

      ### ctrl+backspace
      "\\C-h" = "backward-kill-word";

      ### ctrl+shift+delete
      "\\e[3;6~" = "kill-line";
      "\\e[3@" = "kill-line";
    };
  };
}
