class Understudy < Formula
  desc "A drop-in, CPU-only proxy for System One decision models that learns per-question understudents from the lead's answers"
  homepage "https://github.com/endgame-labs/understudy"
  version "0.1.0-preview.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.1/understudy-aarch64-apple-darwin.tar.xz"
      sha256 "6dc56a0ada0b539ddc3958108194169fbb85fe45af67e23587dbe4349bd69730"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.1/understudy-x86_64-apple-darwin.tar.xz"
      sha256 "8facc404068c71af4a8e006439101c3c23717d1849fa75867b6ec0e668669869"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.1/understudy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1e8e1341547de21886a47dca814c5f830a06983db9271a17caaa6923af791ff3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/endgame-labs/understudy/releases/download/v0.1.0-preview.1/understudy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "610f81041ca499b076817f07a815a86d7b019290c2ccf5d5ae0afea078a46c60"
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
