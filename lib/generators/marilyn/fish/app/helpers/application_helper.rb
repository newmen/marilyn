module ApplicationHelper
  def title(title_text)
    content_for(:title) { title_text }
    content_tag('h1', title_text)
  end

  # нигде не используется
  def hidden_div_if(condition, attributes = {}, &block)
    attributes[:style] = 'display: none' if condition
    content_tag('div', attributes, &block)
  end
end
