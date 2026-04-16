brew-update:
    brew update
    brew upgrade
    brew cleanup --prune=all
    brew autoremove

mise-update:
    mise upgrade
    mise reshim
    mise prune --yes

npm-update:
    mise exec -- npm update -g

fisher-update:
    fish -c "fisher update"

nvim-update:
    nvim --headless "+Lazy! sync" +qa

tldr-update:
    tldr --update

update-all:
    @echo "🔄 Starting environment update..."
    @echo ""
    @echo "🍺 Updating Homebrew..."
    just brew-update
    @echo ""
    @echo "🔧 Updating mise and Node.js..."
    just mise-update
    @echo ""
    @echo "📦 Updating npm packages..."
    just npm-update
    @echo ""
    @echo "🐟 Updating fish plugins..."
    just fisher-update
    @echo ""
    @echo "⚡ Updating Neovim plugins..."
    just nvim-update
    @echo ""
    @echo "📚 Updating tldr cache..."
    just tldr-update
    @echo ""
    @echo "✅ All updates completed!"
