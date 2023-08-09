module FileDownload
  extend ActiveSupport::Concern
  # Here is the example I originally used some time ago - Wes
  # http://johnculviner.com/jquery-file-download-plugin-for-ajax-like-feature-rich-file-downloads/

  # Here is an example of how it should be used per the gem someone created from the data above.
  # I did not install this gem because it only adds assets and the method still needs to be created.
  # https://github.com/rcook/jquery_file_download-rails

  # In the gem above it mentions x_sendfile.  I looked this up for apache
  # https://tn123.org/mod_xsendfile/
  # we may need to install mod_xsendfile

  def print_pdf(output, file_name)
    send_data(output, filename: "#{file_name}.pdf", type: 'application/pdf', x_sendfile: true)
  end

  def send_csv_data(output, file_name = 'data')
    send_data(output,
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: "attachment; filename=#{file_name}.csv",
              x_sendfile: true)
  end

  def send_xlsx_data(output, file_name = 'data')
    send_data(output,
              type: 'application/xlsx; charset=iso-8859-1; header=present',
              disposition: "attachment; filename=#{file_name}.xlsx",
              x_sendfile: true)
  end
end
