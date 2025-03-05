update_app_files() {
    local file_path="$1"

    echo "Customizing '$file_path'..."

    echo "$BUNDLE_NAME=$BUNDLE_NAME"

    # Use `sed` to replace the string
    sed -i '' "s/YOUR_CLIENT_ID_HERE/$YOUR_CLIENT_ID/g" "$file_path/ContentView.swift"
    sed -i '' "s/YOUR_AUTH_TOKEN_HERE/$YOUR_AUTH_TOKEN/g" "$file_path/ContentView.swift"
    sed -i '' "s/YOUR_APP_NAME_HERE/$BUNDLE_NAME/g" "$file_path/ContentView.swift"
    sed -i '' "s/YOUR_KEYBOARD_BUNDLE_ID_HERE/$BUNDLE_ID.appnomixkeyboard/g" "$file_path/ContentView.swift"

    sed -i '' "s/YOUR_APP_GROUP_ID_HERE/$APP_GROUPS_NAME/g" "$file_path/AppnomixKeyboardSDK.swift"

    echo "Replacement done!"
}
