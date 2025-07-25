# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Odigos < Formula
  desc "Odigos CLI Utility"
  homepage "https://odigos.io"
  version "1.0.213-rc4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/odigos-io/odigos/releases/download/v1.0.213-rc4/cli_1.0.213-rc4_darwin_amd64.tar.gz"
      sha256 "135da547c1c5925953a214b2e5338039b592ce087ef8194f9f5c6a1451642242"

      def install
        bin.install "odigos"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/odigos-io/odigos/releases/download/v1.0.213-rc4/cli_1.0.213-rc4_darwin_arm64.tar.gz"
      sha256 "f79ba791664b0bb07a9a9afff2038c0773e41886f7083205dcc27394064cda3b"

      def install
        bin.install "odigos"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://github.com/odigos-io/odigos/releases/download/v1.0.213-rc4/cli_1.0.213-rc4_linux_amd64.tar.gz"
      sha256 "6d9d46906fcd37e08b14da33768e36ea7f5820c190777bf1278c274d73e915e4"
      def install
        bin.install "odigos"
      end
    end
    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://github.com/odigos-io/odigos/releases/download/v1.0.213-rc4/cli_1.0.213-rc4_linux_arm64.tar.gz"
      sha256 "9c69da1b85e2983346a97afd012119512c5c7817f86c7246af6bf437e3e8e4ff"
      def install
        bin.install "odigos"
      end
    end
  end

  def caveats
    <<~EOS
      Thanks for installing Odigos CLI! Please run `odigos install` to install Odigos in your Kubernetes cluster.
    EOS
  end
end
