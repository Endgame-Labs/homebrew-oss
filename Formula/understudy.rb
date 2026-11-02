class Understudy < Formula
  desc "A drop-in, CPU-only proxy for System One decision models that learns per-question understudents from the lead's answers"
  homepage "https://github.com/endgame-labs/understudy"
  version "0.1.0-preview.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.2/understudy-aarch64-apple-darwin.tar.xz"
      sha256 "d7425ea862f80977ddc75028161582d92ee222d5e518fb7b031809c42c980de2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.2/understudy-x86_64-apple-darwin.tar.xz"
      sha256 "d7818a1d25da602ed4b456e5178157987552d6114fab4b8bda0f2e8b4cc0abf4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.2/understudy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "014d96d147113cad37decaf2d2d15e3f5183f78e98efa6f3138a8f71613eec43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.2/understudy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4185e706b9eb60a1bab16e7af17a4282d200a3aba3f913d7c3f5cb1bfef6bee2"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "understudy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "understudy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "understudy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "understudy"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
