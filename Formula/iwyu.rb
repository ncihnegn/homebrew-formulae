
class Iwyu < Formula
  desc "Include What You Use"
  homepage "https://include-what-you-use.org"
  url "https://github.com/include-what-you-use/include-what-you-use/archive/0.15.tar.gz"

  license "LLVM"

  head "https://github.com/include-what-you-use/include-what-you-use.git"

  depends_on "llvm"
  depends_on "cmake" => :build

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/iwyu-0.15" 
    sha256 "2f9c7d8e1004704145a1cd3823435db29cdbb237b34a0e6af593c708e84b10fa" => :catalina
  end

  def install
    system "cmake", "-Bbuild", ".", "-DCMAKE_CXX_STANDARD=17", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

end
