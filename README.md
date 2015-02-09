# Node Raspberry Pi Security Camera

This poject is a node.js alert system. It takes regular photos and diffs
them for changes. When the threshold it exceeded it will notify you
via SMS (via Twilio) and sound an alert. I highly recommend setting the
`alert.mp3` file to be `The Police - Every Breath You Take`.

> Note: This is still in active development, only some of the described
> features work at this time.

### Install

```
git clone git@github.com:adambutler/node-pi-security.git
npm install
coffee index.coffee
```
