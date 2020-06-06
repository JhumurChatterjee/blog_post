module ApplicationHelper
  def full_title(page_title = "")
    base_title = t("page_title")

    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_message_prefix(message_type)
    case message_type
    when "success" then t("success_alert_prefix")
    when "info"    then t("info_alert_prefix")
    when "warning" then t("warning_alert_prefix")
    when "danger"  then t("danger_alert_prefix")
    else ""
    end
  end

  def message_type(message_type)
    case message_type
    when "notice" then t("notice_message_type")
    when "alert"  then t("alert_message_type")
    else message_type
    end
  end
end
