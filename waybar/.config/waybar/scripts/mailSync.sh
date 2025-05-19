#!/bin/sh

ACCOUNT="balkanlinux@disroot.org"

notify-send "📧 Mail Sync" "Starting sync for $ACCOUNT..."
mw -y "$ACCOUNT"
notify-send "📧 Mail Sync" "Mail sync finished."
