class Ipopt < Formula
  desc "Interior Point OPTimizer"
  homepage "https://github.com/coin-or/Ipopt"
  url "https://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.13.tgz"
  sha256 "aac9bb4d8a257fdfacc54ff3f1cbfdf6e2d61fb0cf395749e3b0c0664d3e7e96"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "wget" => :build

  depends_on "openblas"

  def install
    ENV.deparallelize
    Dir.chdir("ThirdParty/Blas") do
      system "./get.Blas"
    end
    Dir.chdir("ThirdParty/Lapack") do
      system "./get.Lapack"
    end
    Dir.chdir("ThirdParty/Mumps") do
      system "./get.Mumps"
    end
    Dir.chdir("ThirdParty/ASL") do
      system "./get.ASL"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/ipopt", "-version"
  end
end
