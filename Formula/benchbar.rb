# Homebrew formula for the benchbar CLI. scripts/homebrew-render.sh fills
# in the url and the sha256 of benchbar-cli-<version>.tar.gz (made by
# scripts/cli-tarball.sh); .github/workflows/homebrew-tap.yml puts the
# result in Formula/benchbar.rb of github.com/askysh/homebrew-tap once the
# release is published (docs/releasing.md).
#
# The wrapper in bin/ runs opt_libexec/benchbar, not the Cellar folder:
# the CLI records the path it runs from (shell helpers, links, fix lines),
# and only the opt path survives brew upgrade and brew cleanup.
class Benchbar < Formula
  desc "Set up, run and repair local Frappe and ERPNext benches on macOS"
  homepage "https://benchbar.akashmishra.com/"
  url "https://github.com/askysh/benchbar/releases/download/v0.8.2/benchbar-cli-0.8.2.tar.gz"
  sha256 "2c9608e205ea3cdf306789870db51ea3f69161bd9485a162e892aa80592af8be"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  def install
    libexec.install Dir["*"]
    bin.write_exec_script opt_libexec/"benchbar"
  end

  def caveats
    <<~EOS
      To set up Frappe on this Mac (asks for sudo once):
        benchbar install

      Coming from the one line installer? Move its state and links over:
        #{opt_bin}/benchbar repair

      Before `brew uninstall benchbar`, stop the background services:
        benchbar uninstall-service --all
    EOS
  end

  test do
    assert_match "benchbar #{version}", shell_output("#{bin}/benchbar --version")
    where = shell_output("#{bin}/benchbar where --json")
    assert_match '"install":"homebrew"', where
    refute_match "/Cellar/", where
  end
end
