module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      return unless site.layouts.key? 'tag'

      dir = 'tag'
      site.data['tags'].each do |tag, info|
        site.pages << TagPage.new(site, site.source, dir, tag, info)
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag, info)
      @site = site
      @base = base
      @dir  = dir
      @name = "#{tag.to_s.downcase}.html"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      
      self.data['title'] = info['display_name'] || tag
      self.data['tag'] = tag
      self.data['description'] = info['description']
      self.data['permalink'] = "/tag/#{tag}/"
    end
  end
end