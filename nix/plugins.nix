{ buildVimPlugin, fetchFromGitHub }:
{
  sarnai-nvim = buildVimPlugin {
    pname = "sarnai-nvim";
    version = "2025-06-20";
    src = fetchFromGitHub {
      owner = "titembaatar";
      repo = "sarnai.nvim";
      rev = "731571823b1b96bc47b28b582e5678a28c39aab9";
      sha256 = "sha256-V7eI3Qty7Z6Il+bp1hkUipcSNF0BlwBprCjKlltW0ik=";
    };
  };
}
