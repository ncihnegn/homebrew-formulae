class Chezscheme < Formula
  desc "Implementation of the Chez Scheme language"
  homepage "https://cisco.github.io/ChezScheme/"
  url "https://github.com/cisco/ChezScheme/archive/v9.5.4.tar.gz"
  head "https://github.com/racket/ChezScheme.git"

  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/chezscheme-9.5.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "0799dcc4e409e05eba46036b5150128bfaa4644e7919749bbf5da6927eb13694"
  end

  def install
    # dyld: lazy symbol binding failed: Symbol not found: _clock_gettime
    # Reported 20 Feb 2017 https://github.com/cisco/ChezScheme/issues/146
    if MacOS.version == "10.11" && MacOS::Xcode.version >= "8.0"
      inreplace "c/stats.c" do |s|
        s.gsub! "CLOCK_MONOTONIC", "UNDEFINED_GIBBERISH"
        s.gsub! "CLOCK_PROCESS_CPUTIME_ID", "UNDEFINED_GIBBERISH"
        s.gsub! "CLOCK_REALTIME", "UNDEFINED_GIBBERISH"
        s.gsub! "CLOCK_THREAD_CPUTIME_ID", "UNDEFINED_GIBBERISH"
      end
    end

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
