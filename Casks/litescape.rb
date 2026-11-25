cask "litescape" do
  arch arm: "arm64", intel: "x86_64"
  platform_suffix = on_system_conditional macos: "mac-universal.dmg", linux: "linux-#{arch}.AppImage"

  version "0.2.0"
  sha256 arm:          "d4c9484f8d54f91097f5b47fea8960f4a0bd2f05995a301665f83548c9c78153",
         intel:        "d4c9484f8d54f91097f5b47fea8960f4a0bd2f05995a301665f83548c9c78153",
         arm64_linux:  "ec2495365fbcba1c132e406be56c9a0ecfad9db08e4f7385efa6714df8848507",
         x86_64_linux: "11112ae93f19076887d1759bfb323c55afa60ff61bcd9f307ed321c22e17215e"

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
