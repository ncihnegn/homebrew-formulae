class Vimr < Formula
  desc "Neovim GUI for macOS"
  homepage "https://vimr.org"
  url "https://github.com/ncihnegn/vimr/archive/v0.32.0-347c.tar.gz"

  bottle do
  end

  depends_on "automake" => :build
  depends_on "carthage" => :build
  depends_on "cmake" => :build
  depends_on "coreutils" => :build
  depends_on "gettext" => :build
  depends_on "gnu-sed" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on xcode: :build

  resource "neovim" do
    url "https://github.com/ncihnegn/neovim/archive/v0.4.3r.tar.gz"
  end

  def install
    neovim_buildpath = buildpath/"NvimView/neovim"
    neovim_buildpath.install resource("neovim")

    system "code_sign=false", "carthage_update=true", "use_carthage_cache=false", "./bin/build_vimr.sh"
    prefix.install build/Build/Products/Release/VimR.app
  end

  def caveats
    <<~EOS
      VimR.app was installed to
        #{prefix}
      To link the application to default Homebrew App location:
        ln -s #{prefix}/VimR.app /Applications
    EOS
  end
end
