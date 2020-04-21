class Systemc < Formula
  desc "Core SystemC language and examples"
  homepage "https://accellera.org/"
  url "https://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.3.tar.gz"

  bottle do 
    root_url "https://github.com/ncihnegn/homebrew-formulae/releases/download/systemc-2.3.3" 
    cellar :any 
    rebuild 1 
    sha256 "bb9104380fee3563794d97cd130a7b10bc4d3ab716ebcf8595b9cddbe5c52490" => :catalina 
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
