module Sortabl
  module ActionViewExtensions
    module SortablHelper

      # Renders sortabl link
      #
      def sortabl_link(name = nil, attribute = nil, html_options = nil, &block)
        html_options, attribute, name = attribute, name, block if block_given?
        html_options = html_options || {}

        # Support custom sort_param
        # If sort_param isn't given, fall back to :sortabl as param
        sort_param = html_options[:sort_param] || :sortabl
        html_options.except!(:sort_param)

        # Remove current sortabl param from url and add default sortabl param
        sortabl_params = params.permit!.except(sort_param)
        sortabl_params[sort_param] = "#{attribute}_asc"

        # If there was already a sortabl param, invert direction or remove sortabl param
        if params[sort_param].present?
          if attribute.to_s == params[sort_param].gsub(/(_asc$|_desc$)/, '')
            sort_direction = params[sort_param].gsub(/^((?!desc$|asc$).)*/, '')

            sortabl_params[sort_param] = "#{attribute}_desc"  if sort_direction == 'asc'
            sortabl_params[sort_param] = nil                  if sort_direction == 'desc'
          end
        end

        # Add sortabl html class to html_options
        html_options[:class] = 'sortabl' + (sort_direction.present? ? " #{sort_direction}" : "") + (html_options[:class].present? ? " #{html_options[:class]}" : "")

        # Support remote true
        html_options.except!(:remote).merge!({'data-remote': 'true'}) if html_options[:remote]

        # Generate url from params
				url = url_for(sortabl_params.permit!)
        html_options["href".freeze] ||= url

        content_tag("a".freeze, name || url, html_options, &block)
      end

    end
  end
end
