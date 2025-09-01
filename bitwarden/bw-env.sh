#!/bin/bash
# Bitwarden CLI environment variables loader

bw_unlock() {
    if ! bw status | grep -q '"status":"unlocked"'; then
        echo "Unlocking Bitwarden vault..."
        export BW_SESSION=$(bw unlock --raw)
        if [ -z "$BW_SESSION" ]; then
            echo "Failed to unlock Bitwarden"
            return 1
        fi
        echo "Bitwarden unlocked"
    fi
}

bw_sync() {
    echo "Syncing Bitwarden vault..."
    bw sync
}

bw_get_env() {
    local item_name="$1"
    local field_name="$2"
    
    if [ -z "$field_name" ]; then
        bw get password "$item_name" 2>/dev/null
    else
        bw get item "$item_name" 2>/dev/null | jq -r ".fields[] | select(.name==\"$field_name\") | .value"
    fi
}

load_bitwarden_env() {
    bw_unlock || return 1
    # export CIRCLECI_API_TOKEN=$(bw_get_env "CircleCI" "api_token")
    # export GEMINI_API_KEY=$(bw_get_env "Gemini" "api_key")
    # export NGROK_DOMAIN=$(bw_get_env "Ngrok" "domain")
    # export NGROK_AUTHTOKEN=$(bw_get_env "Ngrok" "auth_token")
    
    local env_vars=$(bw get notes "Development Environment Variables" 2>/dev/null)
    if [ ! -z "$env_vars" ]; then
        while IFS= read -r line; do
            if [[ "$line" =~ ^[A-Z_]+=.+ ]]; then
                export "$line"
            fi
        done <<< "$env_vars"
        echo "Environment variables loaded from Bitwarden"
    else
        echo "No environment variables found in Bitwarden"
    fi
}

# Uncomment the line below to auto-load when this script is sourced
# load_bitwarden_env