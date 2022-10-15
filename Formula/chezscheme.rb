class Chezscheme < Formula
  desc "Implementation of the Chez Scheme language"
  homepage "https://cisco.github.io/ChezScheme/"
  url "https://github.com/racket/ChezScheme/archive/refs/tags/racket-v8.6.tar.gz"
  head "https://github.com/racket/ChezScheme.git"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/chezscheme-9.5.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "0799dcc4e409e05eba46036b5150128bfaa4644e7919749bbf5da6927eb13694"
  end

  uses_from_macos "ncurses"

  def install
    system "./configure",
              "--installprefix=#{prefix}",
              "--threads",
              "--installschemename=chez"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"hello.ss").write <<~EOS
      (display "Hello, World!") (newline)
    EOS

    expected = <<~EOS
      Hello, World!
    EOS

    assert_equal expected, shell_output("#{bin}/chez --script hello.ss")
  end
end
