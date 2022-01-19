require "middleman-core"
require "pty"
require_relative "tailwind/version"

module Middleman
  module Tailwind
    class Error < StandardError; end
    # Your code goes here...

    class Main < Middleman::Extension
      def ready
        Thread.new do
          system("tailwindcss-linux-x64", out: $stdout)
        end
      end
    end
  end
end

::Middleman::Extensions.register(:tailwind, Middleman::Tailwind::Main)
