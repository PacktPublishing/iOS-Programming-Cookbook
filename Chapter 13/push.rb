require 'houston'

# Environment variables are automatically read, or can be overridden by any specified options. You can also
# conveniently use `Houston::Client.development` or `Houston::Client.production`.
APN = Houston::Client.development
APN.certificate = File.read("/Users/hossamghareeb/Documents/apple_push_notification.pem")

# An example of the token sent back when a device registers for notifications
token = "699C8C3E87A7412E356365F80CEE08C737D541EB135EC5470334C85A5F4E2FCC"

# Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
notification = Houston::Notification.new(device: token)
notification.alert = "Hey man, we are going to cinema tomorrow. Are you in?"

# Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
notification.badge = 57
notification.sound = "sosumi.aiff"
notification.category = "ChatMessageCategory"
notification.content_available = true
notification.custom_data = { foo: "bar" }

# And... sent! That's all it takes.
APN.push(notification)