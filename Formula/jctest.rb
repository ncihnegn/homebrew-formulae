class Jctest < Formula
  desc "A tiny and fast C/C++ single header only test framework"
  homepage "https://github.com/JCash/jctest"
  url "https://github.com/JCash/jctest/archive/v0.5.tar.gz"
  head "https://github.com/ncihnegn/jctest.git", :branch => "dev"

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-DJCTEST_TEST=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #define JC_TEST_IMPLEMENTATION
      #include <jc_test.h>
      unsigned int Factorial( unsigned int number ) {
          return number <= 1 ? number : Factorial(number-1)*number;
      }
      TEST(MyTest, "Factorials are computed") {
          ASSERT_TRUE( Factorial(1) == 1 );
          ASSERT_TRUE( Factorial(2) == 2 );
          ASSERT_TRUE( Factorial(3) == 6 );
          ASSERT_TRUE( Factorial(10) == 3628800 );
      }
      int main(int argc, char** argv) {
          jc_test_init(&argc, argv);
          return jc_test_run_all();
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-o", "test"
    system "./test"
  end
end
