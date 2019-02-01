class Scipoptsuite < Formula
  desc "Solving Constraint Integer Programs"
  homepage "https://scip.zib.de/"
  url "https://scip.zib.de/download/release/scipoptsuite-6.0.1.tgz"
  sha256 "22e75bb5a13a25ff16651fcd0156f9df813d3f82c9643218bc96d0f000cb0478"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "bliss"
  depends_on "gmp"
  depends_on "ipopt"
  depends_on "readline"

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
