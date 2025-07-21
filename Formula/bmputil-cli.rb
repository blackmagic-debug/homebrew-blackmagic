class BmputilCli < Formula
  desc "Black Magic Probe companion Utility Command-line Interface"
  homepage "https://black-magic.org"
  url "https://github.com/blackmagic-debug/bmputil/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2a04346c31ca8f72016e283148c1fdb31c728c3405ea2824f50d70a88d23f78a"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/blackmagic-debug/bmputil.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin/"bmputil-cli", "complete")
    # (man1/"bmputil-cli.1").write Utils.safe_popen_read(bin/"bmputil-cli", "manpage")
  end

  test do
    system bin/"bmputil-cli", "--version"
  end
end
