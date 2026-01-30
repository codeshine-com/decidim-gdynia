# Decidim::Debates::DebateMCell.class_eval do
#
#   def badge_name
#     ''
#   end
#
#   def debate_date
#     return render(:closed_debate) if model.closed?
#     return render(:open_date) unless start_date && end_date
#     return render(:multiple_dates) if spans_multiple_dates?
#
#     render(:single_date)
#   end
#
#   def closed_at
#     return unless model.closed_at
#
#     model.closed_at.to_date
#   end
# end
