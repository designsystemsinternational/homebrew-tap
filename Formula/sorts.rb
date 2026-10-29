class Sorts < Formula
  desc "Font manager for a shared Fonts folder with personal settings"
  homepage "https://github.com/designsystemsinternational/sorts"
  url "https://github.com/designsystemsinternational/sorts/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "58908242d91478505a82382f72ed5ec73f9b9563f2a92bd57a3ecb33d47f3196"
  license "MIT"
  head "https://github.com/designsystemsinternational/sorts.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    ENV["SORTS_CONFIG_DIR"] = testpath/"config"
    (testpath/"Fonts").mkpath
    assert_match "Fonts folder", shell_output("#{bin}/sorts init #{testpath}/Fonts")
    assert_match "Font files:   0", shell_output("#{bin}/sorts status")
    assert_match version.to_s, shell_output("#{bin}/sorts --version")
  end
end
