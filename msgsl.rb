class MsGsl < Formula
  desc "Microsoft's C++ Guidelines Support Library"
  homepage "https://github.com/Microsoft/GSL"
  url "https://github.com/Microsoft/GSL/archive/v2.1.0.tar.gz"
  head "https://github.com/ncihnegn/GSL.git"

  depends_on "cmake" => :build

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/msgsl-2.1.0"
    sha256 "3cd928d9389d6f91bd5f4f5d15e7721e7f4fd318a2f3c5d663d56da75cfdedf0" => :catalina
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
