module RecordsHelper
    
    def calc_repmax(weight,rep)
        rep = rep.to_f
        weight = weight.to_f
        @repmax = sprintf("%.2f", weight * (1+ (rep/40) ))
        return @repmax
    end
    
    def calc_ratio(bodyweight)
        bodyweight = bodyweight.to_f
        @repmax = @repmax.to_f
        ratio = sprintf("%.2f",(@repmax / bodyweight) )
        return ratio
    end
    
    def next_record
        next_record = current_user.records.order('date desc').where("date <= ?", :date).first
        return next_record
    end
end
