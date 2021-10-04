module ArticleBlockDecorator
  def box_header_icon
    if sentence?
      '<i class="fa fa-edit"></i>'.html_safe
    elsif medium?
      '<i class="fa fa-image"></i>'.html_safe
    elsif embed?
      blockable.youtube? ? content_tag(:i, nil,  class: "fa fa-youtube-play") : content_tag(:i, nil, class: "fa fa-twitter")
    end
  end

  def box_title
    if sentence?
      '文章'
    elsif medium?
      'メディア'
    elsif embed?
      '埋め込み'
    end
  end
end
