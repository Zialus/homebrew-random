class Bliss < Formula
  desc "Tool for Computing Automorphism Groups and Canonical Labelings of Graphs"
  homepage "http://www.tcs.hut.fi/Software/bliss/"
  url "http://www.tcs.hut.fi/Software/bliss/bliss-0.73.zip"
  sha256 "f57bf32804140cad58b1240b804e0dbd68f7e6bf67eba8e0c0fa3a62fd7f0f84"

  depends_on "gmp"

  def install
    system "make", "gmp"
    bin.install "bliss"
    lib.install "libbliss.a"
    include.install Dir["*hh"]
  end

  test do
    system "#{bin}/bliss", "-version"
  end
end
