class Cli11 < Formula
  desc "A command line parser for C++11 and beyond"
  homepage "https://github.com/CLIUtils/CLI11"
  url "https://github.com/CLIUtils/CLI11/archive/v1.9.0.tar.gz"
  head "https://github.com/CLIUtils/CLI11.git"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/cli11-1.9.0" 
    cellar :any_skip_relocation 
    sha256 "d048e00d06704f5e93fe4bbec31d4588b8f69d1cef09ba7767abbad31f0d1f47" => :catalina 
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
