[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">

<h3 align="center">Luacord</h3>

  <p align="center">
    <br />
    ·
    <a href="https://github.com/cyntaax/luacord/issues">Report Bug</a>
    ·
    <a href="https://github.com/cyntaax/luacord/issues">Request Feature</a>
  </p>
</p>




<!-- ABOUT THE PROJECT -->
## About The Project

This is a library for interacting with the Discord API in an object-oriented fashion. It is very fresh and still lacking
some features, but has proven useful for my personal cases. For the time being, most things are read-only, however this
will change.

<!-- ![product-screenshot](https://i.gyazo.com/268f17b6814049b8855ca3b9f384a68c.png) -->


<!-- GETTING STARTED -->
## Getting Started

Simply download the [Latest Release](https://github.com/Cyntaax/luacord/releases/latest), place into your resources directory and start!

### Prerequisites

- You will need knowledge on how to create/add a discord bot to your server. [Guide](https://www.writebots.com/discord-bot-token/)

### Configuration

- Set a new key in your `server.cfg` of `luacord_token` along with starting luacord after. See example below

```ini
... (otherconfig)
set luacord_token="abcdefg123"

... (other resources)
ensure luacord
```

## Usage
The resource alone does nothing. It is a library to be included with another resource to interact with discord. For example:

```lua
--- fxmanifest.lua

server_scripts {
    '@luacord/server/server.lua',
    'server/server.lua'
}
```


```lua
--- server/server.lua

local discord_client = LuaCord.new()

local guild = Guild.new(discord_client, "YOUR_GUILD_ID")

--- you'll have to get player's discord identifier without the 'discord:'

local memberId = "MEMBER ID FROM SOMETHING"

guild:GetMember(memberId, function(member)
    print('Member Stuff', json.encode(member.User))
end)

```

<!-- ROADMAP -->
## Roadmap

- Provide Promise based API to avoid callback disaster

See the [open issues](https://github.com/cyntaax/luacord/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'chore: added some amazing feature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Cyntaax - [@cyntaax](https://twitter.com/cyntaax) - cyntaax@gmail.com

Project Link: [https://github.com/cyntaax/luacord](https://github.com/cyntaax/luacord)







<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/cyntaax/luacord.svg?style=for-the-badge
[contributors-url]: https://github.com/cyntaax/luacord/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/cyntaax/luacord.svg?style=for-the-badge
[forks-url]: https://github.com/cyntaax/luacord/network/members
[stars-shield]: https://img.shields.io/github/stars/cyntaax/luacord.svg?style=for-the-badge
[stars-url]: https://github.com/cyntaax/luacord/stargazers
[issues-shield]: https://img.shields.io/github/issues/cyntaax/luacord.svg?style=for-the-badge
[issues-url]: https://github.com/cyntaax/luacord/issues
[license-shield]: https://img.shields.io/github/license/cyntaax/luacord.svg?style=for-the-badge
[license-url]: https://github.com/cyntaax/luacord/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/cyntaax
