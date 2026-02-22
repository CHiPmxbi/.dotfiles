#!/usr/bin/env bash
# Dependencies installation - brew, uv, git

install_homebrew() {
    if command -v brew &> /dev/null; then
        echo "Homebrew already installed."
        return
    fi

    echo ""
    echo "==================================="
    echo "   Installing Homebrew"
    echo "==================================="
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        return
    fi

    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for current session
    if [[ -w "/etc/profile" ]]; then
        echo 'eval "$(brew shellenv)"' >> ~/.bashrc
    fi

    eval "$(brew shellenv)"
}

install_uv() {
    if command -v uv &> /dev/null; then
        echo "uv already installed."
        return
    fi

    echo ""
    echo "==================================="
    echo "   Installing uv"
    echo "==================================="
    echo ""

    # Install via curl
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Add to PATH
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
}

install_git() {
    if command -v git &> /dev/null; then
        echo "git already installed: $(git --version)"
        return
    fi

    echo ""
    echo "==================================="
    echo "   Installing git"
    echo "==================================="
    echo ""

    sudo apt update
    sudo apt install -y git
}

install_deps() {
    install_git
    install_homebrew
    install_uv

    echo ""
    echo "==================================="
    echo "   Dependencies Installed"
    echo "==================================="
    echo ""
    echo "Installed versions:"
    git --version || echo "git: not installed"
    brew --version 2>/dev/null || echo "brew: not installed"
    uv --version 2>/dev/null || echo "uv: not installed"
    echo ""
}

install_deps
