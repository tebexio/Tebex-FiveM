# Tebex_FiveM

Tebex_FiveM is the official FiveM plugin for the [Tebex](https://www.tebex.io) server monitization platform.

This plugin is a complete plugin to check for purchases from the Tebex platform and execute commands in game.

## Alpha

This library is currently in development, so should be considered alpha - functions may change without warning or be untested.

## Support

Please don't raise support issues on this repo. For support with the plugin or any Tebex issues, please [contact support](http://help.tebex.io)

## Contributing

We welcome contributions from the community. Please refer to the CONTRIBUTING.md file for more details. By submitting code to us, you agree to the
terms set out in the CONTRIBUTING.md file

## Installation
We recommend downloading the latest build from your Tebex Control Panel. If you wish to use the git verson, the Tebex-FiveM directory should be copied into your server server-data/resources/ directory.

To force the Tebex-FiveM resource to start when you start your server, add the following line to your server.cfg:

`start Tebex-FiveM`

Tebex-FiveM works by executing commands on your console. You need to give the Tebex-FiveM resource permission to execute commands via ACE:

`add_ace resource.Tebex-FiveM command allow`


