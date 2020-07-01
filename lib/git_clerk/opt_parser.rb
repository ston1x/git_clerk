require 'optparse'
require 'git_clerk/version'

module GitClerk
  class OptParser
    def self.parse
      options = {}

      ### TODO: Handle & design subcommands ###
      ### TODO: Ignore double dashes for subcommands! ###
      # NOTE: how about this ARGV.shift?
      # https://stackoverflow.com/questions/31522912/optionparser-with-subcommands

      ##########

      OptionParser.new do |opts|
        opts.banner = 'Usage: git_clerk [options]'

        opts.on('-v', '--verbose', 'Run verbosely') do |v|
          options[:verbose] = v
          puts v
        end

        opts.on('clerk', 'Clerk in the current directory') do
          puts "CLERKING......"
        end

        opts.on('help', 'Print help') do
          puts opts
        end

        opts.on('version', 'Get version info') do
          puts "GitClerk v#{GitClerk::VERSION}"
        end
      end.parse!
    end
  end
end
