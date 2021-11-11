{ pkgs ? (import <nixpkgs> {}).pkgs }:
with pkgs.python39Packages;

pkgs.mkShell{
  venvDir = "./.venvDir";
  name = "impureGoEnv";
  buildInputs = [
	# poetry env
	pkgs.python39
	pkgs.poetry

	# python libs - rather basic
	numpy
	networkx
	pkgs.libspatialindex
	dateutil
	pandas
	Rtree

	# openai gym deps
	gym
	pyglet
	
	# jupyter nb
	jupyter
	ipykernel
	ipywidgets
	jupyterlab
	
	# for go
	scikit-learn

	# needed for pip
	pip
	setuptools
	venvShellHook
	];
  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -e . -U
  '';
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}

