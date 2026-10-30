class Sorts < Formula
  desc "Font manager for a shared Fonts folder with personal settings"
  homepage "https://github.com/designsystemsinternational/sorts"
  url "https://github.com/designsystemsinternational/sorts/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "78a91771fe013f1c338db0073ce08ecdecfc2efc0d76c93e572358766f5bf535"
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
