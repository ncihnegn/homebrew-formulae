class Doctest < Formula
  desc "Fast feature-rich C++1x single-header testing framework"
  homepage "https://github.com/onqtam/doctest"
  url "https://github.com/onqtam/doctest/archive/2.3.7.tar.gz"
  head "https://github.com/onqtam/doctest.git"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/doctest-2.3.7" 
    cellar :any_skip_relocation 
    rebuild 1 
    sha256 "6283e6f271e3a47ae1342210bb6eb0504e3edc8e83c1764f57ab571f0a56b011" => :catalina
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-DCMAKE_CXX_STANDARD=17", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
      #include <doctest/doctest.h>
      unsigned int Factorial( unsigned int number ) {
          return number <= 1 ? number : Factorial(number-1)*number;
      }
      TEST_CASE( "Factorials are computed") {
          REQUIRE( Factorial(1) == 1 );
          REQUIRE( Factorial(2) == 2 );
          REQUIRE( Factorial(3) == 6 );
          REQUIRE( Factorial(10) == 3628800 );
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-o", "test"
    system "./test"
  end
end
