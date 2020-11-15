class Systemc < Formula
  desc "Core SystemC language and examples"
  homepage "https://accellera.org/"
  url "https://github.com/ncihnegn/systemc/archive/v2.3.3.1.tar.gz"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/systemc-2.3.3.1" 
    rebuild 1 
    sha256 "f56e3c1d5484d405f9207011f605c545341270581f4bbdb4d6dc3e06cdbbd20e" => :catalina
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-Bbuild", ".", "-DCMAKE_CXX_STANDARD=17", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <systemc>

      int sc_main(int argc, char *argv[]) {
        return 0;
      }
    EOS
    system ENV.cxx, "-L#{lib}", "-lsystemc", "test.cpp"
    system "./a.out"
  end
end
