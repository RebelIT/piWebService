class ApiReturns
  def get_action
    msg = ["Calendar Action",
          "Actions: #{action_accept}",
          "Methods: POST",
          "Param: action, token",
          "Example:",
          "     {",
          "      \"action\" : \"xxxxxxxx\"",
          "      }"
        ].join("\n") + "\n"
    return msg
  end

  def get_calendar
    msg = ["action",
          "Perform actions against the wall mounted calendar"
        ].join("\n") + "\n"
    return msg
  end

  def action_accept
    msg = "reboot, shutdown, update"
    return msg
  end
end
