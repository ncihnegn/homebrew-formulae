class Toml11 < Formula
  desc "TOML for modern c++"
  homepage "https://github.com/ToruNiina/toml11"
  url "https://github.com/ToruNiina/toml11/archive/v3.3.0.tar.gz"
  head "https://github.com/ToruNiina/toml11.git"

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", *std_cmake_args
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
