class Yap < Formula
  desc "Prolog compiler designed for performance and extensibility"
  homepage "https://www.dcc.fc.up.pt/~vsc/yap/"

  head do
    url "https://github.com/vscosta/yap-6.3.git"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build

  depends_on "gmp"
  depends_on "mysql"
  depends_on "open-mpi"
  depends_on "openssl"
  depends_on "postgresql"
  depends_on "python"
  depends_on "r"
  depends_on "raptor"
  depends_on "readline"

  def install
    args = std_cmake_args + %W[
      -WITH_READLINE=#{Formula["readline"].opt_prefix}
      -WITH_GMP=#{Formula["gmp"].opt_prefix}
      -WITH_THREADS
      -WITH_DEPTH_LIMIT
      -WITH_TABLING
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/yap", "-dump-runtime-variables"
  end
end
