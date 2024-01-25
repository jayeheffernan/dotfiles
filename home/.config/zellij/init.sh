#! /usr/bin/env bash

function start-session() {
  local session_name="$1"

  # Send Zellij cli to shell
  wezterm cli send-text "zellij --layout $session_name --session $session_name"
  # send Enter key
  wezterm cli send-text --no-paste ''
  # Wait a moment so Zellij has time to start
  sleep 2
  # send "detach" keybinding to Zellij
  wezterm cli send-text --no-paste 'd'
}

function attach-session() {
  local session_name="$1"
  wezterm cli send-text "zellij attach $session_name"
  wezterm cli send-text --no-paste ''
}

start-session logs
start-session proxy
start-session website
start-session flex
start-session ludwig

attach-session ludwig
