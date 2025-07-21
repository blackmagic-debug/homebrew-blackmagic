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

  bottle do
    root_url "https://github.com/blackmagic-debug/homebrew-blackmagic/releases/download/bmputil-cli-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a067bdf80e2767000b7baad3bc36b0cfd1edd2c08625590a134892af20c3fae1"
    sha256 cellar: :any_skip_relocation, ventura:       "4eaa480bb4d4135ebe1d63176c6b021ba9066a79be780fcf4db5e6aea811bc32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33aca5ca4454e242b3597e1280c7e48c0a9c2d5120f7fee61885b4ba7d6af8d3"
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
