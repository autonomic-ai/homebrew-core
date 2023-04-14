class Bundletool < Formula
  desc "Command-line tool to manipulate Android App Bundles"
  homepage "https://github.com/google/bundletool"
  url "https://github.com/google/bundletool/releases/download/1.14.1/bundletool-all-1.14.1.jar"
  sha256 "2f78f9c8d059db1c7ea4ac6ffb2527466af03838d150b70f4b77fe7deefca011"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, ventura:        "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, monterey:       "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, big_sur:        "32deed7a065fc682c488378b5b5d976c981d50bbb3915f10488cc888c108dff2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6da5446853683797e16d5cc780adee297b58512c9b294d4675d56642cea9f95"
  end

  depends_on "openjdk"

  resource "homebrew-test-bundle" do
    url "https://gist.githubusercontent.com/raw/ca85ede7ac072a44f48c658be55ff0d3/sample.aab"
    sha256 "aac71ad62e1f20dd19b80eba5da5cb5e589df40922f288fb6a4b37a62eba27ef"
  end

  def install
    libexec.install "bundletool-all-#{version}.jar" => "bundletool-all.jar"
    bin.write_jar_script libexec/"bundletool-all.jar", "bundletool"
  end

  test do
    resource("homebrew-test-bundle").stage do
      expected = <<~EOS
        App Bundle information
        ------------
        Feature modules:
        	Feature module: base
        		File: dex/classes.dex
      EOS

      assert_equal expected, shell_output("#{bin}/bundletool validate --bundle sample.aab")
    end
  end
end
