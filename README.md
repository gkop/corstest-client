# Corstest.com client

## Run a development server

```bash
bundle install
middleman server
```

If you want to develop against a local instance of [corstest-server](https://github.com/gkop/corstest-server), you may quickly point the client at your local server by adding a line to your hostfile:

```bash
sudo sh -c 'echo "127.0.0.1 corstest-api.coshx.com" >> /etc/hosts'
```

## Build the site

```bash
middleman build
```
