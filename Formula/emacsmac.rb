class Emacsmac < Formula
  desc "YAMAMOTO Mitsuharu's Mac port of GNU Emacs"
  homepage "https://www.gnu.org/software/emacs/"
  url "https://bitbucket.org/mituharu/emacs-mac/get/emacs-27.1-mac-8.1.tar.gz"
  version "8.1"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/emacsmac-8.1" 
    rebuild 1 
    sha256 "fb776160acaefa49527e462fbe2161fad83c72a83cd55afa713e581f0e990571" => :catalina
  end

  head "https://bitbucket.org/mituharu/emacs-mac.git", branch: "work"

  option "with-dbus", "Build with d-bus support"
  option "without-modules", "Build without dynamic modules support"
  option "with-rsvg", "Build with rsvg support"
  option "with-ctags", "Don't remove the ctags executable that emacs provides"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "d-bus" if build.with? "dbus"
  depends_on "glib" => :optional
  depends_on "gnutls"
  depends_on "imagemagick" => :optional
  depends_on "jansson" => :recommended
  depends_on "librsvg" if build.with? "rsvg"
  depends_on "libxml2" => :recommended
  depends_on "pkg-config" => :build
  depends_on "texinfo" => :"build"

  def install
    args = [
      "--enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp",
      "--infodir=#{info}/emacs",
      "--prefix=#{prefix}",
      "--with-mac",
      "--enable-mac-app=#{prefix}",
      "--with-gnutls",
      "--with-pdumper",
    ]
    args << "--with-modules" unless build.without? "modules"
    args << "--with-rsvg" if build.with? "rsvg"

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
    prefix.install "NEWS-mac"

    # Follow Homebrew and don't install ctags from Emacs. This allows Vim
    # and Emacs and exuberant ctags to play together without violence.
    if build.without? "ctags"
      (bin/"ctags").unlink
      (share/man/man1/"ctags.1.gz").unlink
    end

    if build.with? "starter"
      # Replace the symlink with one that starts GUI
      # alignment the behavior with cask
      # borrow the idea from emacs-plus
      (bin/"emacs").unlink
      (bin/"emacs").write <<~EOS
        #!/bin/bash
        exec #{prefix}/Emacs.app/Contents/MacOS/Emacs.sh "$@"
      EOS
    end
  end

  def caveats
    <<~EOS
      This is YAMAMOTO Mitsuharu's "Mac port" addition to
      GNU Emacs. This provides a native GUI support for Mac OS X
      10.6 - 10.15. After installing, see README-mac and NEWS-mac
      in #{prefix} for the port details.

      Emacs.app was installed to:
        #{prefix}

      To link the application to default Homebrew App location:
        ln -s #{prefix}/Emacs.app /Applications
      Other ways please refer:
        https://github.com/railwaycat/homebrew-emacsmacport/wiki/Alternative-way-of-place-Emacs.app-to-Applications-directory

      For an Emacs.app CLI starter, see:
        https://gist.github.com/4043945
    EOS
  end

  test do
    assert_equal "4", shell_output("#{bin}/emacs --batch --eval=\"(print (+ 2 2))\"").strip
  end
end
