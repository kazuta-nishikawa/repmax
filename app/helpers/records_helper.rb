module RecordsHelper
    
    def calc_repmax(weight,rep)
        rep = rep.to_f
        weight = weight.to_f
        @repmax = sprintf("%.2f", weight * (1+ (rep/40) ))
        return @repmax
    end
    
    def calc_ratio(body_weight)
        body_weight = body_weight.to_f
        @repmax = @repmax.to_f
        ratio = sprintf("%.2f",(@repmax / body_weight) )
        return ratio
    end

end
