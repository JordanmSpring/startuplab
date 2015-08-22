Rails.application.assets.register_engine('.haml', Tilt::HamlTemplate)
Rails.application.assets.js_compressor = Uglifier.new(mangle: false)

Rails.application.assets.context_class.class_eval do
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
end
