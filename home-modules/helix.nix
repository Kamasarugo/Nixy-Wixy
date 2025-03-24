{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        indent-guides.render = true;
        line-number = "relative";
      };
    };
  };
}
