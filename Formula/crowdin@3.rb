class CrowdinAT3 < Formula
  desc "Crowdin CLI is a command-line tool that allows you to manage and synchronize localization resources with your Crowdin project."
  homepage "https://support.crowdin.com/cli-tool-v3/"
  url "https://downloads.crowdin.com/cli/v3/crowdin-cli-3.1.13.zip"
  sha256 "a913f37d03523ff361d6839369afec07b63abaee56ec265d604dbc6dfb8aac9a"
  version :"3.1.13"

  bottle :unneeded

  keg_only :versioned_formula

  depends_on :java => "1.8+"

  def install
    libexec.install "crowdin-cli.jar"
    bin.write_jar_script libexec/"crowdin-cli.jar", "crowdin"
  end

  test do
    generate_output = shell_output("#{bin}/crowdin generate").chomp
    assert_predicate testpath/"crowdin.yml", :exist?
    assert_match /^Generating Crowdin CLI configuration skeleton .*crowdin\.yml\'- OK$/, generate_output
    lint_output = shell_output("#{bin}/crowdin lint", 1).split("\n")
    assert_match /^`Source` parameter is empty$/, lint_output[0]
    assert_match /^`Translation` parameter is empty$/, lint_output[1]
  end
end
