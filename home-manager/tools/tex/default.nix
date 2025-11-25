
{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      texlive.combined.scheme-medium
    ];
  };
  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim-latex-live-preview
    ];
  };
}
