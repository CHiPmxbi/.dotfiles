#!/usr/bin/env bash
# System configuration - hifiberry config

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/output"

generate_hifiberry_config() {
    local output_file="$OUTPUT_DIR/hifiberry-config.txt"

    cat > "$output_file" << 'EOF'
# Hifiberry DAC+ Configuration
# Add to /boot/config.txt

# Enable HiFiBerry DAC+
dtoverlay=hifiberry-dacplus
dtparam=audio=off

# Optional: Enable I2S
# dtoverlay=hifiberry-dacplus,dtparam=slave
EOF

    echo ""
    echo "==================================="
    echo "   HiFiBerry Config Generated"
    echo "==================================="
    echo "Output: $output_file"
    echo ""
    echo "To apply:"
    echo "  1. Copy to /boot/config.txt"
    echo "  2. Or append to existing /boot/config.txt"
    echo "  3. Reboot your Raspberry Pi"
    echo ""
    echo "Content:"
    cat "$output_file"
    echo ""
}

generate_hifiberry_config
