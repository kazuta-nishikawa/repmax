# frozen_string_literal: true

module RecordsHelper
  def calc_repmax(weight, rep)
    rep = rep.to_f
    weight = weight.to_f
    @repmax = format('%.2f', weight * (1 + (rep / 40)))
    @repmax
  end

  def calc_ratio(body_weight)
    body_weight = body_weight.to_f
    @repmax = @repmax.to_f
    format('%.2f', (@repmax / body_weight))
  end
end
