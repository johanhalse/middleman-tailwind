require "middleman-core"
require "pry"
require_relative "tailwind/version"
require_relative "tailwind/upstream"

module Middleman
  module Tailwind
    class Error < StandardError; end

    class Main < Middleman::Extension
      option :config_path, nil, "Custom tailwind.config.js file path"
      option :css_path, nil, "Tailwind source css file path"
      option :destination_path, "source/stylesheets/tailwind.css", "Destination path for tailwind css"

      def initialize(app, options_hash = {}, &block)
        super

        @gem_dir = File.expand_path "../..", __dir__
        @project_dir = Dir.pwd
        @config_path = options.config_path
        @css_path = options.css_path
        @destination_path = options.destination_path
      end

      def platform
        %i[cpu os].map { |m| Gem::Platform.local.send(m) }.join("-")
      end

      def executable
        Upstream::NATIVE_PLATFORMS[platform]
      end

      def application_css
        return File.join(@project_dir, @css_path) if @css_path

        File.join(@gem_dir, "tailwind/application.tailwind.css")
      end

      def destination
        File.join(@project_dir, @destination_path)
      end

      def config_file
        return File.join(@project_dir, @config_path) if @config_path

        File.join(@gem_dir, "tailwind/tailwind.config.js")
      end

      def ready
        exe = File.join(@gem_dir, "exe/#{executable}")
        cmd = "#{exe} -c #{config_file} -i #{application_css} -o #{destination}"

        if app.mode?(:server)
          Thread.new do
            system("#{cmd} -w", out: $stdout)
          end
        else
          puts "Building Tailwind CSS..."
          system(cmd, out: $stdout)
        end
      end
    end
  end
end

::Middleman::Extensions.register(:tailwind, Middleman::Tailwind::Main)
