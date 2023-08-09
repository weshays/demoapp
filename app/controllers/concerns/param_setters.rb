module ParamSetters
  extend ActiveSupport::Concern

  def set_common_options
    @sort = set_sort
    @order = set_order
    @page = set_page
    @per_page = set_per_page
    @paginate = set_paginate
    @search = set_search
    @filters = set_filters
  end

  private

  #####################################################
  ## Controller helper methods to be overwritten
  #####################################################
  def app_filters_enabled
    true
  end

  def app_search_enabled
    true
  end

  def enable_default_order_by
    true
  end

  def enable_id_order
    true
  end

  # def translated_column
  #   'id' # This method should be overwritten
  # end
  #####################################################

  def apply_filters(query)
    # This method should be overwritten if filters are to be used
    query
  end

  def apply_search(query)
    @search.blank? ? query : query.search_for(@search)
  end

  def sort_column
    params[:sort]
  end

  def set_sort
    translated_column
  end

  def set_order
    %w[ASC DESC].include?(params[:order].to_s.upcase) ? params[:order].to_s.upcase : 'ASC'
  end

  def set_page
    params[:page].to_i.zero? ? 1 : params[:page]
  end

  def set_per_page
    page_num = params.to_unsafe_h.to_snake_keys.symbolize_keys[:per_page].to_i
    (1..1000).cover?(page_num) ? page_num : 25
  end

  def set_paginate
    [false, 'false', 0, '0'].exclude?(params[:paginate])
  end

  def set_search
    params[:search].presence
  end

  def set_filters
    return {} if params[:filters].blank?

    JSON.parse(params.to_unsafe_h.to_snake_keys['filters'].to_json, symbolize_names: true)
  end
end
