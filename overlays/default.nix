# ./overlays/default.nix
{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    # overlayer1 - 参数名用 self 与 super，表达继承关系
    (self: super: {
      fcitx5-rime = super.fcitx5-rime.override {
        rimeDataPkgs = [./rime-data-flypy];
      };
    })
  ];
}