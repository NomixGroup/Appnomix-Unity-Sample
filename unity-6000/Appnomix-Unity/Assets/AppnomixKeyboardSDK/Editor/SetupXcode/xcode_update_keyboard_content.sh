#!/bin/bash

update_keyboard_files() {
    local file_path="$1"

    echo "Customizing '$file_path'..."

    echo "$BUNDLE_NAME=$BUNDLE_NAME"

    # Use `sed` to replace the string
    sed -i '' "s/YOUR_CLIENT_ID_HERE/$YOUR_CLIENT_ID/g" "$file_path/KeyboardViewController.swift"
    sed -i '' "s/YOUR_AUTH_TOKEN_HERE/$YOUR_AUTH_TOKEN/g" "$file_path/KeyboardViewController.swift"
    sed -i '' "s/YOUR_APP_NAME_HERE/$BUNDLE_NAME/g" "$file_path/KeyboardViewController.swift"
    sed -i '' "s/YOUR_APP_SCHEME_HERE/$YOUR_APP_SCHEME/g" "$file_path/KeyboardViewController.swift"
    sed -i '' "s/YOUR_APP_GROUP_ID_HERE/$APP_GROUPS_NAME/g" "$file_path/KeyboardViewController.swift"

    echo "Replacement done!"
}
