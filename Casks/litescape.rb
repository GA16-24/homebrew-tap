cask "litescape" do
  arch arm: "arm64", intel: "x86_64"
  platform_suffix = on_system_conditional macos: "mac-universal.dmg", linux: "linux-#{arch}.AppImage"

  version "0.1.0"
  sha256 arm:          "90c3807cb684b7de6db5f931a068d9d59648c8154f4284b510e68dacd40acfd6",
         intel:        "90c3807cb684b7de6db5f931a068d9d59648c8154f4284b510e68dacd40acfd6",
         arm64_linux:  "7c4a715b4df6604dcc8fb3eb7c2e15a6a357ae37f20a854ca017d26542507e99",
         x86_64_linux: "b59c2a03a0c27da6475ab157b4d6e494e2b0eeaa18074eab351f23c20e40b94c"

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
