{ vimUtils, fetchFromGitHub }:
{
  sarnai-nvim = vimUtils.buildVimPlugin {
    pname = "sarnai-nvim";
    version = "2025-06-20";
    src = fetchFromGitHub {
      owner = "titembaatar";
      repo = "sarnai.nvim";
      rev = "731571823b1b96bc47b28b582e5678a28c39aab9";
      sha256 = "sha256-V7eI3Qty7Z6Il+bp1hkUipcSNF0BlwBprCjKlltW0ik=";
    };
  };

  kanso-nvim = vimUtils.buildVimPlugin {
    pname = "kanso-nvim";
    version = "2025-07-15";
    src = fetchFromGitHub {
      owner = "webhooked";
      repo = "kanso.nvim";
      rev = "748023fd273782e6e056620ce66a176532cdf375";
      sha256 = "sha256-REpAQJQnYTWrGnqeb5S7jgDjmMvSUE4JqT+BcSonxfw=";
    };
  };
}
