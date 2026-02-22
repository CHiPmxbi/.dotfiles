#!/usr/bin/env bash
# Shell setup - starship, fonts, emoji

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/output"

install_starship() {
    if command -v starship &> /dev/null; then
        echo "Starship already installed."
        return
    fi

    echo "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh

    # Add to shell config
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
}

generate_shell_config() {
    local output_file="$OUTPUT_DIR/shell-config.sh"

    cat > "$output_file" << 'EOF'
# Starship Prompt Configuration
# Add to ~/.bashrc or ~/.zshrc

# Starship init (add to end of ~/.bashrc)
# eval "$(starship init bash)"

# Emoji support (optional)
# Some fonts need this for emoji display
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
EOF

    echo ""
    echo "==================================="
    echo "   Shell Config Generated"
    echo "==================================="
    echo "Output: $output_file"
    echo ""
    echo "To apply:"
    echo "  1. Source: source $output_file"
    echo "  2. Or append content to ~/.bashrc"
    echo ""
}

install_fonts() {
    echo ""
    echo "==================================="
    echo "   Installing Fonts"
    echo "==================================="
    echo ""
    echo "Recommended fonts for emoji support:"
    echo "  - Noto Color Emoji (apt)"
    echo "  - Symbola"
    echo "  - JoyPixels"
    echo ""
    read -p "Install Noto Color Emoji? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt install -y fonts-noto-color-emoji
    fi
}

setup_shell() {
    install_starship
    install_fonts
    generate_shell_config

    echo ""
    echo "==================================="
    echo "   Shell Setup Complete"
    echo "==================================="
    echo ""
}

setup_shell
