class CalendarAction
  def reboot
    delay = "1"
    shell = system( "reboot +#{delay}" )
    return "System is going down for a reboot in #{delay} min"
  end

  def shutdown
    delay = "1"
    shell = system( "shutdown +#{delay}" )
    return "System is going down and not coming back in #{delay} min"
  end

  def update
    shell = system( "apt-get update -y && apt-get dist-upgrade && reboot" )
    return "System is updating, sevices may be interrupted"
  end
end
