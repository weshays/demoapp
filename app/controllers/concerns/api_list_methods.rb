module ApiListMethods
  extend ActiveSupport::Concern
  include PaginationMethods

  def api_list_render(objs, options = {})
    set_common_options
    override_common_options(options)
    update_sorts_and_orders(options) # (objs, options) # objs is not needed right now
    objs = apply_filters(objs) if app_filters_enabled
    objs = apply_search(objs) if app_search_enabled
    collection =
      if @paginate
        objs.page(@page).per(@per_page).order(order_by(objs).join(', '))
      else
        objs.order(order_by.join(', '))
      end
    render_options = { json: collection }
    extra_serializer_options(render_options, options)
    render render_options
  end

  def override_common_options(options)
    @page = options[:page] if options.key?(:page)
    @per_page = options[:per_page] if options.key?(:per_page)
  end

  # (objs, options)
  def update_sorts_and_orders(options)
    @sort = options[:sort] if options.key?(:sort)
    @sort = nil if options[:valid_sorts].present? && options[:valid_sorts].exclude?(@sort)
    @sort = options[:default_sort] if options.key?(:default_sort) && @sort.blank?
    @order = options[:order] if options.key?(:order)
  end

  def order_by(objs = nil)
    return [] unless enable_default_order_by

    order = []
    order << "#{@sort} #{@order} NULLS LAST" if @sort.present?
    order << "#{@sort2} #{@order2 || @order} NULLS LAST" if @sort2.present?
    if objs.present? && ['id', "#{objs.table_name}.id"].exclude?(@sort.to_s) && enable_id_order
      order << "#{objs.table_name}.id ASC"
    end
    order
  end

  # def apply_secondary_sort(options)
  #   @sort2 = options[:sort]
  #   @order2 = options[:order2] if options[:order].present?
  # end

  def extra_serializer_options(render_options, options)
    render_options[:meta] = {}
    render_options[:meta].merge!(paginate_objects(render_options[:json])) if @paginate
    render_options[:meta].merge!(data_filters)
    render_options.merge!(options[:options]) if options.key?(:options)
    render_options[:root] = options[:root] if options.key?(:root)
    render_options[:serializer] = options[:serializer] if options[:serializer].present?
    render_options[:each_serializer] = options[:each_serializer] if options[:each_serializer].present?
    true
  end

  def data_filters
    {
      filters: params[:filters],
      search: params[:search],
      sort: params[:sort],
      order: params[:order]
    }
  end
end
