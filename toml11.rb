class Toml11 < Formula
  desc "TOML for modern c++"
  homepage "https://github.com/ToruNiina/toml11"
  url "https://github.com/ToruNiina/toml11/archive/v3.1.0.tar.gz"

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
  end
end
