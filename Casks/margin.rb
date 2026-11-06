# Homebrew cask for Margin.app. scripts/homebrew-render.sh fills in the version
# and the DMG's sha256; .github/workflows/homebrew-tap.yml puts the result in
# Casks/margin.rb of github.com/askysh/homebrew-tap once a release is published.
cask "margin" do
  version "0.0.2"
  sha256 "a23b2080204c26d900d8b6e01ead6cf24daea57b8e8ff696f1e506e17582f71a"

  url "https://github.com/askysh/margin/releases/download/v#{version}/Margin-#{version}.dmg"
  name "Margin"
  desc "Meeting notepad with local transcription and speaker names"
  homepage "https://github.com/askysh/margin"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Margin.app"

  uninstall launchctl: "com.akashmishra.margin.login",
            quit:      "com.akashmishra.margin"

  zap trash: [
    "~/Library/Application Support/Margin",
    "~/Library/Caches/com.akashmishra.margin",
    "~/Library/LaunchAgents/com.akashmishra.margin.login.plist",
    "~/Library/Preferences/com.akashmishra.margin.plist",
    "~/Library/Saved Application State/com.akashmishra.margin.savedState",
    "~/Library/WebKit/com.akashmishra.margin",
  ]

  caveats <<~EOS
    Margin updates itself. It needs macOS 14.4 or later for call recording.
    Your meetings stay in the folder you chose, also after `brew uninstall --zap`.
  EOS
end
