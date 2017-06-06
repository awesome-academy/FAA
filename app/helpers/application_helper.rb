module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def not_found
    render file: "public/404.html", layout: false, status: 404
  end

  def check_paginator? page
    page.left_outer? || page.right_outer? || page.inside_window?
  end

  def view_object name
    if name.is_a?(Symbol)
      class_name = name.to_s.titleize.split(" ").join("")
    else
      class_name = name.split("/")
        .map{|name_split| name_split.titleize.sub(" ", "")}.join("::")
    end
    class_name.constantize.new(self)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def footer_social_links
    networks = %w(facebook twitter gplus pinterest vimeo github yahoo linkedin)
    networks.map do |network|
      link_to Settings.social_links[network],
        class: "social-icon si-small si-borderless si-#{network}" do
        content_tag(:i, nil, class: "icon-#{network}") +
        content_tag(:i, nil, class: "icon-#{network}")
      end
    end
  end
end
