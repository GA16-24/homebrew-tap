cask "litescape" do
  arch arm: "arm64", intel: "x86_64"
  platform_suffix = on_system_conditional macos: "mac-universal.dmg", linux: "linux-#{arch}.AppImage"

  version "0.3.2"
  sha256 arm:          "0fdc8b9e7113ce2660c77122a01d36b598b99cc31996c34825ff3cf3f3dc81f8",
         intel:        "0fdc8b9e7113ce2660c77122a01d36b598b99cc31996c34825ff3cf3f3dc81f8",
         arm64_linux:  "4b4574352844d27b7852f50c43fee37aad280603331cea86224fe727f082fc37",
         x86_64_linux: "d3aa847f0db1df3ae20fe657ae9485383e15df60f94dfe658e072df6b7d0a562"

  on_macos do
    app "Litescape.app"

    # shortcut: the app is only ad-hoc signed, so Gatekeeper would block it; drop this once it is notarized.
    postflight_steps do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Litescape.app"]
    end

    zap trash: "~/Library/Application Support/Litescape"
  end
  on_linux do
    app_image "Litescape-#{version}-linux-#{arch}.AppImage", target: "Litescape.AppImage"

    zap trash: "~/.config/Litescape"
  end

  url "https://github.com/GA16-24/homebrew-tap/releases/download/v#{version}/Litescape-#{version}-#{platform_suffix}"
  name "Litescape"
  desc "Desktop viewer for Litematica schematics from the Litescape Minecraft mod"
  homepage "https://github.com/GA16-24/homebrew-tap"
end
