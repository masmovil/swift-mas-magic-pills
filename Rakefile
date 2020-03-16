# frozen_string_literal: true

task default: %w[setup]

task(:setup) do
  unless system('which brew')
    raise '`brew` is required. Please install brew. https://brew.sh/'
  end
  puts('➡️ Brew 🍺')
  sh('brew install sourcery')
  sh('brew install swiftlint')

  puts('➡️ Bundle 💎')
  sh('bundle install')

  puts('➡️  Overcommit')
  sh('bundle exec overcommit --install')
  sh('bundle exec overcommit --sign')
  sh('bundle exec overcommit --sign pre-commit')
end
