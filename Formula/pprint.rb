class Pprint < Formula
  desc "Pretty printer for modern C++"
  homepage "https://github.com/p-ranav/pprint"
  url "https://github.com/ncihnegn/pprint/archive/v1.0.0.tar.gz"
  head "https://github.com/ncihnegn/pprint.git"

  bottle do
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/pprint-1.0.0"
    sha256 cellar: :any_skip_relocation, catalina: "2b0ea22ea888d7eb9ba2ca1840ca321e02d7a0f37622f5a6f5c2563f8a4cac54"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-DCMAKE_CXX_STANDARD=17", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    cp_r pkgshare/"test", testpath
    cd "test" do
      system ENV.cxx, "--std=c++17", "-I#{testpath}/test", "main.cpp", "-o", "tests"
      system "./tests"
    end
  end
end
