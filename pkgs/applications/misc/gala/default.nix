# SPDX-FileCopyrightText: 2022 Unikie

{ pkgs, nodejs, stdenv, fetchFromGitHub, lib, ... }:

let
  # src = fetchFromGitHub {
  #   owner = "solita";
  #   repo = "tii-saca-ga-la";
  #   rev = "5492cfeeda15fb3205d344f0dc0396f8e7aa798f";
  # };

  src = ./tii-saca-ga-la.zip;
  # nodejs-14_x

  nodePackages = import ./node-composition.nix
  {
    inherit pkgs;
    inherit (stdenv.hostPlatform) system;
    nodejs = pkgs."nodejs-14_x";
  };

in
nodePackages.package.override {
  pname = "gala";
  version = "0.0.1";

  inherit src;

  nativeBuildInputs = [ pkgs.buildPackages.makeWrapper ];

  preInstall = ''
    echo "PRE INSTALL"
  '';

  postInstall = ''
    echo "POST INSTALL"
  '';

  meta = with lib; {
    description = "GALA app";
    maintainers = with maintainers; [ beardhatcode ];
    license = licenses.asl20;
  };
}
