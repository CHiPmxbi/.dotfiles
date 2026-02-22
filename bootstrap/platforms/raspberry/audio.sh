#!/usr/bin/env bash
# Audio dependencies - PyAudio

install_pyaudio_deps() {
    echo ""
    echo "==================================="
    echo "   Installing PyAudio Dependencies"
    echo "==================================="
    echo ""
    echo "This will install:"
    echo "  - python3-pyaudio"
    echo "  - portaudio19-dev"
    echo "  - libportaudio2"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        return
    fi

    echo "Updating package list..."
    sudo apt update

    echo "Installing PyAudio dependencies..."
    sudo apt install -y python3-pyaudio portaudio19-dev libportaudio2

    echo ""
    echo "==================================="
    echo "   PyAudio Dependencies Installed"
    echo "==================================="
    echo ""
    echo "To install PyAudio Python package:"
    echo "  uv add pyaudio"
    echo "  # or"
    echo "  pip install pyaudio"
    echo ""
}

install_pyaudio_deps
