# Homebrew cask for BenchBar.app. scripts/homebrew-render.sh fills in the
# version and the DMG's sha256; .github/workflows/homebrew-tap.yml puts the
# result in Casks/benchbar-app.rb of github.com/askysh/homebrew-tap once a
# signed release is published (docs/releasing.md).
#
# The app drives the CLI, so the cask depends on the benchbar formula. Brew
# installs the formula first when both names are given:
#   brew install askysh/tap/benchbar askysh/tap/benchbar-app
cask "benchbar-app" do
  version "0.7.0"
  sha256 "d2bafdb554d8d5c383d3736d4ec133d6c98fdcf8963beb846fb25f201304a358"

  url "https://github.com/askysh/benchbar/releases/download/v#{version}/BenchBar-#{version}.dmg"
  name "BenchBar"
  desc "Menu bar runner for local Frappe and ERPNext development benches"
  homepage "https://benchbar.akashmishra.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "askysh/tap/benchbar"
  depends_on macos: :sonoma

  app "BenchBar.app"

  uninstall quit: "com.akashmishra.benchbar"

  zap trash: [
    "~/Library/Application Support/BenchBar",
    "~/Library/Caches/BenchBarSnapshots",
    "~/Library/Caches/com.akashmishra.benchbar",
    "~/Library/HTTPStorages/com.akashmishra.benchbar",
    "~/Library/Preferences/com.akashmishra.benchbar.plist",
  ]

  caveats <<~EOS
    BenchBar updates itself. To set up Frappe on this Mac, run once:
      benchbar install
    Frappe and ERPNext are trademarks of Frappe Technologies.
    BenchBar is not affiliated with or endorsed by them.
  EOS
end
