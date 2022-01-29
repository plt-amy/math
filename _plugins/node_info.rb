# frozen_string_literal: true
require 'cgi'

class NodeInfo
  def initialize(resource)
    @node = resource
  end

  def title
    @node["title"]
  end

  def slug
    @node["slug"]
  end

  # This is a very strange routine, but at least the logic is factored out here.
  def has_title?
    title != slug.downcase
  end

  def taxon
    @node["taxon"]
  end

  def genus
    if taxon == "section" then
      "Section"
    else
      @node["genus"] || "Result"
    end
  end

  def display_index
    "<span class='numbering'>#{genus} #{clicks_to_numbering @node['clicks']}</span>"
  end

  def display_title
    taxon.nil? ? title : (display_index + (has_title? ? ". #{title}" : ""))
  end

  def display_title_parenthetical
    taxon.nil? ? title : (display_index + (has_title? ? " (#{title})" : ""))
  end

  def aria_label
    label = taxon.nil? ? title : ("#{genus} #{clicks_to_numbering @node['clicks']}." + (has_title? ? " #{title}" : ""))
    CGI.escapeHTML label
  end
end

