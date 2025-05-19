#!/bin/sh

MAILDIR="$HOME/.local/share/mail/balkanlinux@disroot.org"

# Count unread mails (files in all 'new' folders inside maildir)
unread=$(find "$MAILDIR" -type d -name new -exec find {} -type f \; | wc -l)

if [ "$unread" -gt 0 ]; then
	echo "  $unread "

else
	echo "  "
fi
