**NEVER change this file without explicit user confirmation or instruction to do so.**

1. Modules should be as self-contained as possible and reasonable
2. Hibernation with no resume offset in the config works as systemd writes it as an EFI variable at hibernation
3. If a tool isn't available just use `nix run nixpkgs#[tool]` or `nix shell nixpkgs#[tool]` to gain access instead of finding a workaround
4. Run `nix fmt`, deadnix and statix before commiting
5. Commit messages should follow conventional commits
