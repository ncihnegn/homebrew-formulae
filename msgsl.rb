class Msgsl < Formula
  desc "Microsoft's C++ Guidelines Support Library"
  homepage "https://github.com/Microsoft/GSL"
  url "https://github.com/Microsoft/GSL/archive/v3.0.1.tar.gz"
  head "https://github.com/ncihnegn/GSL.git"

  depends_on "cmake" => :build

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/msgsl-3.0.1" 
    cellar :any_skip_relocation 
    sha256 "782181adb74383c17541013c6e2f199961e4b6e68eb3c3efd5070a70dfab6815" => :catalina
  end

  def install
    system "cmake", ".", "-DGSL_TEST=false", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <gsl/gsl>
      int main() {
        gsl::span<int> z;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-o", "test", "-std=c++14"
    system "./test"
  end
end
