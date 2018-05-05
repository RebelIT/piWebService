action_accept = "reboot, shutdown, update"

get_calendar = ["action",
                "Perform actions against the wall mounted calendar"
              ].join("\n") + "\n"


get_action = ["Calendar Action",
              "Actions: #{action_accept}",
              "Methods: POST",
              "Param: action, token",
              "Example:",
              "     {",
              "      \"token\" : \"xxxxxxxx\"",
              "      \"action\" : \"xxxxxxxx\"",
              "      }"
            ].join("\n") + "\n"
