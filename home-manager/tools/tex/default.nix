
{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      texliveMedium
    ];
  };
  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim-latex-live-preview
    ];
  };
}
