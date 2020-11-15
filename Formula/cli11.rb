class Cli11 < Formula
  desc "A command line parser for C++11 and beyond"
  homepage "https://github.com/CLIUtils/CLI11"
  url "https://github.com/CLIUtils/CLI11/archive/v1.9.1.tar.gz"
  head "https://github.com/CLIUtils/CLI11.git"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/cli11-1.9.1" 
    cellar :any_skip_relocation 
    sha256 "03cecccd26c21498ab8c7f9f84c124789b68035338364e413d2a5d22a818f2f6" => :catalina
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-DCLI11_BUILD_TESTS=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <CLI/CLI.hpp>
      int main(int argc, char* argv[]) {
          CLI::App app{"App"};
          std::string filename = "default";
          app.add_option("-f,--file", filename, "Filename ");
          CLI11_PARSE(app, argc, argv);
          return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-o", "test"
    system "./test"
  end
end
