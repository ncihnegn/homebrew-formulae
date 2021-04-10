class Toml11 < Formula
  desc "TOML for modern c++"
  homepage "https://github.com/ToruNiina/toml11"
  url "https://github.com/ToruNiina/toml11/archive/v3.4.0.tar.gz"
  head "https://github.com/ToruNiina/toml11.git"

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/toml11-3.4.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "f6dee93c830ddfbbd9796d5e93d79bb377358ed30bed169fd195d073adaa39ae"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-Dtoml11_BUILD_TEST=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <toml.hpp>
      #include <iostream>

      int main()
      {
          const auto data = toml::parse("example.toml");

          // title = "an example toml file"
          std::string title = toml::find<std::string>(data, "title");
          std::cout << "the title is " << title << std::endl;

          // nums = [1, 2, 3, 4, 5]
          std::vector<int> nums  = toml::find<std::vector<int>>(data, "nums");
          std::cout << "the length of `nums` is" << nums.size() << std::endl;

          return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-o", "test"
    system "./test"
  end
end
