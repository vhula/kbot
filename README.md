# kbot

Sample of a Telegram bot using the telebot SDK.

## Building

```bash
go build -ldflags "-X="YOUR_MODULE/cmd.appVersion=APP_VERSION
```

Replace YOUR_MODULE and APP_VERSION with your values. For example,
```bash
go build -ldflags "-X="github.com/vhula/kbot/cmd.appVersion=v1.0.2
```

## Running

### Env Configuration

The application requires an env variable called TELE_TOKEN.

```bash
read -s TELE_TOKEN
export $TELE_TOKEN
```

### Starting the bot

```
./kbot start
```
