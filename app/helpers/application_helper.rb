module ApplicationHelper
  def embedded_svg(filename)
    assets = Rails.application.assets
    asset = assets.find_asset("#{filename}.svg")
    if asset
      file = asset.source.force_encoding('UTF-8')
      doc = Nokogiri::HTML::DocumentFragment.parse file
    else
      doc = "<!-- SVG #{filename} not found -->"
    end
    raw doc
  end
end
