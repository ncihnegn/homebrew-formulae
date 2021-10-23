class Chezscheme < Formula
  desc "Implementation of the Chez Scheme language"
  homepage "https://cisco.github.io/ChezScheme/"
  url "https://github.com/cisco/ChezScheme/archive/v9.5.4.tar.gz"
  sha256 "258a4b5284bb13ac6e8b56acf89a7ab9e8726a90cc57ea1cd71c5da442323840"
  head "https://github.com/racket/ChezScheme.git"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/chezscheme-9.5.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "0799dcc4e409e05eba46036b5150128bfaa4644e7919749bbf5da6927eb13694"
  end

  uses_from_macos "ncurses"

  def install
    if Hardware::CPU.arm?
      system "./configure --pb"
      system "make tarm64osx.bootquick"
      system "mkdir", "-p", "bin/tarm64osx"
      system "ln", "-s", "tarm64osx/bin/scheme", "bin/tarm64osx"
    end

    system "./configure",
              "--installprefix=#{prefix}",
              "--threads",
              "--installschemename=chez"
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
