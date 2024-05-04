{ inputs, config, pkgs, ... }:

{

  imports = [
    # ./fcitx5
    ./i3
    # ./programs
    ./rofi
    # ./shell
    ./terminals
    ./programs
    #./editors/neovim
    # ./wm/hyprland
    ./wm/hyprland/config.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "dabao";
    homeDirectory = "/home/dabao";
    stateVersion = "23.11";

    sessionVariables = {
      QT_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    plugins = [
      inputs.hycov.packages.${pkgs.system}.hycov
      inputs.hypreasymotion.packages.${pkgs.system}.hypreasymotion
    ];
    systemd.enable = true;
  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ] ++ (with pkgs; [ swaylock-effects swayidle pamixer ]);

  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];

}
