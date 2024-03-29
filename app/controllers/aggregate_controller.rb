class AggregateController < ApplicationController
  def cpvVsCompany
=begin
    sqlString = ""
    cpvGroup.tender_cpv_classifiers.each do |classifier|
      sqlString = sqlString + " cpv_code = " + classifier.cpv_code + " OR"
    end
    #remove last OR
    sqlString = sqlString[0..-3]
      
    tenders = Tender.where(sqlString)
    
    companies = {}
    tenders.each do |tender|
      tenderValue = 0
      last = nil
      tender.agreements.each do |agreement|
      #find lastest agreement
        if not last or agreement.amendment_number > last.amendment_number
          last = agreement
        end
      end # for each agreement
      if last
        liveDataSetID = Dataset.where(:is_live => true).first.id
        id = last.organization_url
        tenderValue = last.amount
        company = Organization.where(["dataset_id = ? AND organization_url = ?", liveDataSetID, id]).first
        companyData = companies[company.organization_url]
        if not companyData
          companies[company.organization_url] = { :total => 0, :company => company}
        else
          companyData[:total] = companyData[:total] + tenderValue  
          companies[company.organization_url] = companyData
        end
      end
    end# for all tenders   
=end 
    companies = {}
    cpvGroup = CpvGroup.find(params[:cpvGroup])
    cpvGroup.tender_cpv_classifiers.each do |classifier|
      cpvAggregates = AggregateCpvRevenue.where(:cpv_code => classifier.cpv_code)
      cpvAggregates.each do |companyAggregate|
        companyData = companies[companyAggregate.organization_id]
        company = Organization.find(companyAggregate.organization_id)
        if not companyData
          companies[companyAggregate.organization_id] = { :total => companyAggregate.total_value, :company => company }
        else
          companyData[:total] = companyData[:total] + companyAggregate.total_value  
          companies[companyAggregate.organization_id] = companyData
        end
      end
    end


    totalContractValues = []   
    companyArray = []
    companies.each do |index,hash|
      companyArray.push(hash)
    end
    companyArray.sort! { |a,b| (a[:total] > b[:total] ? -1 : 1) }
    @TopTen = []
    count = 1
    companyArray.each do |company|
      @TopTen.push(company)
      count = count + 1
      if count > 10
        break
      end
    end

  end
end
