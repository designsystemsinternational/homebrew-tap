class Sorts < Formula
  desc "Font manager for a shared Fonts folder with personal settings"
  homepage "https://github.com/designsystemsinternational/sorts"
  url "https://github.com/designsystemsinternational/sorts/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "16f1e7b9670df49f7d99682fdf63e5b0a248eb207058c155dc06d73bafbbb402"
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
