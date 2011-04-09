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
end
