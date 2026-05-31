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
    languages.language = [
      {
        name = "python":
        rulers = [
          80
          100
        ];
      }
    ];
  };
}
