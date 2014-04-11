# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Helpers::XMLSitemap

module PostHelper

  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def get_post_start(post)
    content = post.compiled_content
    if content =~ /vapalargo/
      content = content.partition('vapalargo').first +
      "<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
    end
    return content
  end

  #creates tags pages
  def generate_tags(items)
    require 'set'
    tags = Set.new

    #iterate over each post
    items.each do |post|
      #add a each post tag to tags collection
      unless post[:tags].nil?
        post[:tags].each { |tag| tags.add(tag.downcase) }
      end
    end

    #create new page item dynamically per tag
    tags.each do |tag|
      items << Nanoc::Item.new(
        "",
        { :tag => tag },
        "/tags/#{tag}/")
    end
  end
end

include PostHelper
