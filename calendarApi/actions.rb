class CalendarAction
  def reboot
    shell = spawn( "sudo sleep 60 && sudo reboot" )
    return "System is going down for a reboot"
  end

  def shutdown
    shell = spawn( "sudo sleep 60 && sudo shutdown" )
    return "System is going down and not coming back"
  end

  def update
    shell = spawn( "sudo apt-get update -y && sudo apt-get dist-upgrade sudo && reboot" )
    return "System is updating, sevices may be interrupted"
  end
end
