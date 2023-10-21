module IconsHelper
  def fa_solid(icon, size: 2, classes: nil)
    tag.span(class: "icon #{classes}") do
      tag.i(class: "fas fa-#{icon} fa-size-#{size}")
    end
  end

  def fa_regular(icon, size: 2, classes: nil)
    tag.span(class: "icon #{classes}") do
      tag.i(class: "far fa-#{icon} fa-size-#{size}")
    end
  end

  def fa_brands(icon, size: 2, classes: nil)
    tag.span(class: "icon #{classes}") do
      tag.i(class: "fab fa-#{icon} fa-size-#{size}")
    end
  end
end