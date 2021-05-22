module RecordsHelper
    
    def calc_repmax(weight,rep)
        @repmax = sprintf("%.2f", weight * (1+ (rep/40.to_f) )).to_f
        return @repmax
    end
    
    def calc_ratio(bodyweight)
        ratio = sprintf("%.2f",(@repmax / bodyweight).to_f)
        return ratio
    end
end
