 class Tender < ActiveRecord::Base

  has_many :bidders, :dependent => :destroy
  has_many :agreements, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  belongs_to :datasets
  belongs_to :watch_tenders

  attr_accessible :id,
      :url_id,
      :dataset_id,
      :procurring_entity_id,
      :tender_type,
      :tender_registration_number,
      :tender_status,
      :tender_announcement_date,
      :bid_start_date,
      :bid_end_date,
      :estimated_value,
      :include_vat,
      :cpv_code,
      :addition_info,
      :units_to_supply,
      :supply_period,
      :offer_step,
      :guarantee_amount,
      :guarantee_period

  validates :url_id, :tender_type, :tender_registration_number, :tender_status, :presence => true
  
  scope :recent, order("tender_announcement_date desc").limit(5)

  attr_accessor :sum_estimated_value, :count_tender_status, :procurring_entity_name
  
  # number of items per page for pagination
self.per_page = 20

  ############################################################
  ### special attributes
  ############################################################
  def cpv_number
    if !self.cpv_code.nil? && !self.cpv_code.empty?
      return self.cpv_code[1,self.cpv_code.index("-")-1]
    end
  end
  
  def cpv_name
    if !self.cpv_code.nil? && !self.cpv_code.empty?
      return self.cpv_code[self.cpv_code.index("-")+1, self.cpv_code.length]
    end
  end
  
  def sum_estimated_value_formatted
    if self[:sum_estimated_value]
      return ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(self[:sum_estimated_value]))
    end
  end

  ############################################################
  ### aggregate queries
  ############################################################
  # get top estimated values by cpv code
  def self.top_cpv_estimated_values(limit)
    values = []
    sql = "select cpv_code, sum(estimated_value) as sum_estimated_value "
    sql << "from tenders "
    sql << "where cpv_code is not null and length(cpv_code) > 0 "
    sql << "group by cpv_code "
    sql << "order by sum_estimated_value desc "
    sql << "limit :limit " if limit
    
    query = find_by_sql([sql, :limit => limit])
    
    if query && !query.empty?
      query.each do |item|
        hash = Hash.new
        hash[:cpv_number] = item.cpv_number
        hash[:cpv_name] = item.cpv_name
        hash[:sum_value] = item[:sum_estimated_value].to_f
        hash[:sum_formatted_value] = item.sum_estimated_value_formatted
        values << hash
      end
    end
    
    return values
  end

  # get proportion of tender status
  def self.tender_status_proportional
    values = []
    sql = "select tender_status, count(*) as count_tender_status "
    sql << "from tenders "
    sql << "group by tender_status "
    sql << "order by count_tender_status desc, tender_status asc "
    
    query = find_by_sql(sql)
    
    if query && !query.empty?
      total = query.map{|x| x[:count_tender_status]}.inject{|sum,x| sum + x }

      query.each do |item|
        hash = Hash.new
        hash[:tender_status] = item.tender_status
        hash[:number] = item[:count_tender_status]
        hash[:percent] = ActionController::Base.helpers.number_to_percentage(item[:count_tender_status].to_f / total * 100)
        values << hash
      end
    end
    return values
  end
  

end
