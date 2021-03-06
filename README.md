# bashbot
A Telegram bot written in bash.

## Instructions
### Create your first bot

1. Message @botfather https://telegram.me/botfather with the following
text: `/newbot`
   If you don't know how to message by username, click the search
field on your Telegram app and type `@botfather`, you should be able
to initiate a conversation. Be careful not to send it to the wrong
contact, because some users has similar usernames to `botfather`.

2. @botfather replies with `Alright, a new bot. How are we going to
call it? Please choose a name for your bot.`

3. Type whatever name you want for your bot.

4. @botfather replies with `Good. Now let's choose a username for your
bot. It must end in bot. Like this, for example: TetrisBot or
tetris_bot.`

5. Type whatever username you want for your bot, minimum 5 characters,
and must end with `bot`. For example: `telesample_bot`

6. @botfather replies with:

    Done! Congratulations on your new bot. You will find it at
telegram.me/telesample_bot. You can now add a description, about
section and profile picture for your bot, see /help for a list of
commands.

    Use this token to access the HTTP API:
    <b>123456789:AAG90e14-0f8-40183D-18491dDE</b>

    For a description of the Bot API, see this page:
https://core.telegram.org/bots/api

7. Note down the 'token' mentioned above.

### Get Chat Id
1. Click on the link @botfather provides (e.g. `telegram.me/telesample_bot`).

2. Send any text to the bot.

3. Open `https://api.telegram.org/bot<TOKEN>/getUpdates` in your browser (note: replace `<TOKEN>` with your token (see step 7).

4. In the response you will find the Chat Id

### Install bashbot
Clone the repository:
```
git clone https://github.com/jensGiehl/telegram-bot-bash
```

Store the *token* (see step 7) as an environment variable:
```
export TELEGRAM_BOTNAME=<YOUR TOKEN>
```

Store the *chat id* also as an environment variable:
```
export TELEGRAM_CHAT_ID=<YOUR CHAT ID>
```


### Usage
To send messages use the ```-t``` or ```--text```:
```
./bashbot.sh -t "Hello world"
./bashbot.sh --text "Hello world"
```
To send images, videos, voice files, photos ecc use ```-f``` or ```--file``` (just files from your home directory can be send):
```
./bashbot.sh -f ~/myPicture.png
./bashbot.sh --file ~/myPicture.png
```
