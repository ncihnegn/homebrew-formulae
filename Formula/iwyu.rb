
class Iwyu < Formula
  desc "Include What You Use"
  homepage "https://include-what-you-use.org"
  url "https://github.com/include-what-you-use/include-what-you-use/archive/0.15.tar.gz"

  license "LLVM"

  head "https://github.com/include-what-you-use/include-what-you-use.git"

  depends_on "llvm"
  depends_on "cmake" => :build

  bottle do
  end

  def install
    system "cmake", "-Bbuild", ".", "-DCMAKE_CXX_STANDARD=17", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

end
