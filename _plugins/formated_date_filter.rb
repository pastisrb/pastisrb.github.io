module Jekyll
  module FormatedDateFilter
    def formated_date(date)
      time(date).strftime("%d/%m/%Y")
    end
  end
end

Liquid::Template.register_filter(Jekyll::FormatedDateFilter)