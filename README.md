Audioboo is in danger. It is now Audioboom.

Before it goes the way of Seesmic and gets fed to the dogs I am building an export
tool to get all my audio and metadata.

TO USE:

1. In the rails console, create a new user with your Audioboo username and uid (no CRUD yet).
2. Run rake bada:boom[uid,page] and the tool will parse the feed and save your emotions.

BELLS AND WHISTLES

For shits and giggles, the main app uses Pusher to update on export jobs on the front end.