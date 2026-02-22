#!/usr/bin/env bash
set -e

# Bootstrap script for Raspberry Pi
# Interactive menu for system setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/output"
PLATFORM="raspberry"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_platform() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Check if Raspberry Pi
        if [[ -f /proc/device-tree/model ]] && grep -q "Raspberry" /proc/device-tree/model 2>/dev/null; then
            PLATFORM="raspberry"
        else
            PLATFORM="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="darwin"
    elif [[ "$OSTYPE" == "win32" ]]; then
        PLATFORM="win32"
    fi
    log_info "Detected platform: $PLATFORM"
}

show_menu() {
    echo ""
    echo "==================================="
    echo "   Raspberry Pi Bootstrap Menu"
    echo "==================================="
    echo "1. System Config (hifiberry)"
    echo "2. Audio Dependencies (PyAudio)"
    echo "3. Install Dependencies (brew, uv, git)"
    echo "4. Shell Setup (starship, fonts)"
    echo "5. Run All"
    echo "0. Exit"
    echo ""
    echo -n "Select option: "
}

run_system() {
    log_info "Running system config..."
    source "$SCRIPT_DIR/platforms/$PLATFORM/system.sh"
}

run_audio() {
    log_info "Installing audio dependencies..."
    source "$SCRIPT_DIR/platforms/$PLATFORM/audio.sh"
}

run_deps() {
    log_info "Installing dependencies..."
    source "$SCRIPT_DIR/platforms/$PLATFORM/deps.sh"
}

run_shell() {
    log_info "Setting up shell..."
    source "$SCRIPT_DIR/platforms/$PLATFORM/shell.sh"
}

main() {
    detect_platform

    if [[ "$PLATFORM" != "raspberry" ]]; then
        log_warn "This bootstrap script is designed for Raspberry Pi only."
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 0
        fi
    fi

    while true; do
        show_menu
        read -r choice
        echo

        case $choice in
            1) run_system ;;
            2) run_audio ;;
            3) run_deps ;;
            4) run_shell ;;
            5)
                run_system
                run_audio
                run_deps
                run_shell
                ;;
            0)
                log_info "Exiting..."
                exit 0
                ;;
            *)
                log_error "Invalid option"
                ;;
        esac
    done
}

main "$@"
