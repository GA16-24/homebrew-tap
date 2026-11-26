cask "litescape" do
  arch arm: "arm64", intel: "x86_64"
  platform_suffix = on_system_conditional macos: "mac-universal.dmg", linux: "linux-#{arch}.AppImage"

  version "0.3.0"
  sha256 arm:          "ec0138c6ceac642c8436e8ef2a52fe3569186aaca8dbeb8e08752fca73a08490",
         intel:        "ec0138c6ceac642c8436e8ef2a52fe3569186aaca8dbeb8e08752fca73a08490",
         arm64_linux:  "72617c066a0667ed75bf0ab664726bae12ef17ed9b52ed0ddadc2d96792f4f08",
         x86_64_linux: "e66de62c07487c57c440632fdef33c143bbc36aa59e86c5c2eae4bd737d941af"

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
