class Scipoptsuite < Formula
  desc "Solving Constraint Integer Programs"
  homepage "https://scipopt.org"
  url "https://www.scipopt.org/download/release/scipoptsuite-7.0.1.tgz"
  sha256 "971962f2d896b0c8b8fa554c18afd2b5037092685735d9494a05dc16d56ad422"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "bliss"
  depends_on "boost"
  depends_on "gmp"
  depends_on "ipopt"
  depends_on "readline"
  depends_on "tbb"

  def install
    args = std_cmake_args + %W[
      -DBLISS_DIR=#{Formula["bliss"].opt_prefix}
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"simple.lp").write <<~EOS
      Maximize
       obj: x1 + 2 x2 + 3 x3 + x4
      Subject To
       c1: - x1 + x2 + x3 + 10 x4 <= 20
       c2: x1 - 3 x2 + x3 <= 30
       c3: x2 - 3.5 x4 = 0
      Bounds
       0 <= x1 <= 40
       2 <= x4 <= 3
      General
       x4
      End
    EOS

    system "#{bin}/scip", "-c", "read simple.lp optimize quit"
  end
end
