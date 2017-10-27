Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( admin.css admin.js custom.js)
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/


