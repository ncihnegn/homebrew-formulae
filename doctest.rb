class Doctest < Formula
  desc "Fast feature-rich C++1x single-header testing framework"
  homepage "https://github.com/onqtam/doctest"
  url "https://github.com/onqtam/doctest/archive/2.4.0.tar.gz"
  head "https://github.com/onqtam/doctest.git"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/doctest-2.3.8" 
    cellar :any_skip_relocation 
    sha256 "9af8b9c61429fc4caeaa9c41d074c16dfc56c9a808281f61525082b9a7404f68" => :catalina
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
