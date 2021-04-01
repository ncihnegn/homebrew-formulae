class Emacsmac < Formula
  desc "YAMAMOTO Mitsuharu's Mac port of GNU Emacs"
  homepage "https://www.gnu.org/software/emacs/"
  url "https://bitbucket.org/mituharu/emacs-mac/get/emacs-27.2-mac-8.2.tar.gz"
  version "8.2"

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
  option "with-no-title-bars",
         "Build with a patch for no title bars on frames (not recommended to use with --HEAD option)"
  option "with-natural-title-bar",
         "Build with a patch for title bar color inferred by theme (not recommended to use with --HEAD option)"
  option "with-starter", "Build with a starter script to start emacs GUI from CLI"
  option "with-mac-metal", "use Metal framework in application-side double buffering (experimental)"

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

  if build.with? "no-title-bars"
    # odie "--with-no-title-bars patch not supported on --HEAD" if build.head?
    patch do
      url "https://raw.githubusercontent.com/railwaycat/homebrew-emacsmacport/667f0efc08506facfc6963ac1fd1d5b9b777e094/patches/emacs-26.2-rc1-mac-7.5-no-title-bar.patch"
      sha256 "8319fd9568037c170f5990f608fb5bd82cd27346d1d605a83ac47d5a82da6066"
    end
  end

  if build.with? "natural-title-bar"
    patch do
      url "https://raw.githubusercontent.com/railwaycat/homebrew-emacsmacport/667f0efc08506facfc6963ac1fd1d5b9b777e094/patches/emacs-mac-title-bar-7.4.patch"
      sha256 "5512577b3495ed10442883e79b2ec1c8a1325495698eee8c1f0a0d90574de897"
    end
  end

  # patch for multi-tty support, see the following links for details
  # https://bitbucket.org/mituharu/emacs-mac/pull-requests/2/add-multi-tty-support-to-be-on-par-with/diff
  # https://ylluminarious.github.io/2019/05/23/how-to-fix-the-emacs-mac-port-for-multi-tty-access/
  patch do
    url "https://raw.githubusercontent.com/railwaycat/homebrew-emacsmacport/667f0efc08506facfc6963ac1fd1d5b9b777e094/patches/multi-tty-27.diff"
    sha256 "5a13e83e79ce9c4a970ff0273e9a3a07403cc07f7333a0022b91c191200155a1"
  end

  def install
    args = [
      "--enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp",
      "--infodir=#{info}/emacs",
      "--prefix=#{prefix}",
      "--with-mac",
      "--enable-mac-app=#{prefix}",
      "--with-gnutls",
    ]
    args << "--with-modules" unless build.without? "modules"
    args << "--with-rsvg" if build.with? "rsvg"
    args << "--with-mac-metal" if build.with? "mac-metal"

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
      GNU Emacs. This provides a native GUI support for Mac OS X.
      After installing, see README-mac and NEWS-mac
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
