class Msgsl < Formula
  desc "Microsoft's C++ Guidelines Support Library"
  homepage "https://github.com/Microsoft/GSL"
  url "https://github.com/Microsoft/GSL/archive/v3.1.0.tar.gz"
  head "https://github.com/ncihnegn/GSL.git"

  depends_on "cmake" => :build

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/msgsl-3.1.0" 
    cellar :any_skip_relocation 
    sha256 "e6b991fabff2e1d27e0533d451319d5a157d38775407ba0eeeeb3d09335038d5" => :catalina
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
