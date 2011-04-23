module EventsHelper
  # needs to be set in a method
  def ordinalize_date(date)
    "#{date.strftime("%B")} #{date.strftime("%d").to_i.ordinalize}"
  end

  def blank_time(time)
    if time.blank?
      "TBA"
    else
      time.strftime("%l:%M %p")
    end
  end

  def category_image(category)
    category.gsub(/\s*/,'')
  end

  def next_month(marker)
    if (marker.month != (marker + 1.days).month) or (marker.month != (marker - 1.days).month)
      "next"
    elsif beginning_of_week?(marker) and (marker.month != (marker - 1.weeks).month)
      "prev"
    end
  end

  def beginning_of_week?(date)
    date == date.beginning_of_week
  end
end
