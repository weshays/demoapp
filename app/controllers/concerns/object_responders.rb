module ObjectResponders
  extend ActiveSupport::Concern

  def respond_with_object_or_message_status(obj, serializer = nil, options = {})
    if obj.errors.full_messages.empty?
      render_options = { json: obj }
      render_options[:serializer] = serializer unless serializer.nil?
      render_options[:root] = options[:root] if options.key?(:root)
      render(render_options) && return
    else
      not_acceptable(obj)
    end
  end

  def destroy_or_respond_with_message_status(obj, options = {})
    if (obj.respond_to?(:purge) && obj.purge) || obj.destroy
      render_options = { json: obj, serializer: ApiSuccessSerializer }
      render_options[:root] = options[:root] if options.key?(:root)
      render(render_options) && return
    else
      not_acceptable(obj)
    end
  end

  def mark_deleted_or_respond_with_message_status(obj, options = {})
    return unless obj.mark_deleted!

    render_options = { json: obj, serializer: ApiSuccessSerializer }
    render_options[:root] = options[:root] if options.key?(:root)
    render(render_options) && return
  end
end
