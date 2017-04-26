class Tabs < ViewObject
  def html
    safe_join tabs
  end

  private

  def tabs
    raise "must be implemented by subclass"
  end

  def active? tab
    return true if tab.to_s == context.controller_name
    false
  end

  def tab_class tab
    active_class = active?(tab) ? "current" : "mega-menu"
    [active_class].compact.join(" ")
  end

  def build_tab text, path, tab_name
    content_tag :li, class: tab_class(tab_name) do
      link_to path do
        content_tag :div, text
      end
    end
  end
end
