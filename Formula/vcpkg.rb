class Vcpkg < Formula
  desc "C++ Library Manager for macOS, Linux and Windows"
  homepage "https://docs.microsoft.com/en-us/cpp/vcpkg"
  url "https://github.com/microsoft/vcpkg/archive/2020.04.tar.gz"
  head "https://github.com/Microsoft/vcpkg.git"

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/vcpkg-2020.04"
    sha256 cellar: :any_skip_relocation, catalina: "151290b52c0635504710e8c14b8b2d1af5f470fd6a2796cd0cb7cf1cbeae690d"
  end

  depends_on "cmake"
  depends_on "ninja"

  def install
    system "./bootstrap-vcpkg.sh", "-disableMetrics", "-useSystemBinaries", "-allowAppleClang"
    cp_r "#{buildpath}/.", prefix
    bin.install "./vcpkg"
  end

  test do
    assert_match version.to_s, pipe_output("#{bin}/vcpkg version")
  end
end
