# hubot-sendgrid

SendGrid commands for hubot

## Installation

```
npm install --save hubot-sendgrid
```

Add `"hubot-sendgrid"` into your hubot project's `external-scripts.json`

Set `HUBOT_SENDGRID_USER` to your SendGrid user

Set `HUBOT_SENDGRID_KEY` to your SendGrid API key (password)

## Usage


#### Statistics

```
hubot sendgrid stats

hubot sendgrid stats YYYY-MM-DD
```

#### Blocks, Bounces, Invalids, Unsubscribes, and Spam Reports

```
hubot sendgrid blocks # First 10 blocks of today

hubot sendgrid invalids # First 10 invalid emails of today

hubot sendgrid bounces 20 # First 20 bounces of today

hubot sendgrid unsubscribes YYYY-MM-DD # First 10 unsubscribes on YYYY-MM-DD

hubot sendgrid spam reports YYYY-MM-DD 20 # First 20 spam reports on YYYY-MM-DD
```
