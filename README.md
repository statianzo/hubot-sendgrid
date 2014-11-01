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

#### Blocks, Bounces, and Unsubscribes

```
hubot sendgrid blocks # Last 10 blocks

hubot sendgrid bounces 20 # Last 20 bounces

hubot sendgrid unsubscribes YYYY-MM-DD # Bounces on YYYY-MM-DD (limit 100)
```
