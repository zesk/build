
# Web Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `urlMatchesLocalFileSize` - Compare a remote file size with a local file size

Compare a remote file size with a local file size

#### Usage

    urlMatchesLocalFileSize url file
    

#### Arguments



#### Exit codes

- `0` - Always succeeds 

### `urlContentLength` - Get the size of a remote URL

Get the size of a remote URL

#### Exit codes

- `0` - Always succeeds

#### Depends

    curl
     

#### Exit codes

- `0` - Always succeeds 

### `hostTTFB` - Fetch Time to First Byte and other stats

Fetch Time to First Byte and other stats

#### Exit codes

- `0` - Always succeeds

### `websiteScrape` - Uses wget to fetch a site, convert it to HTML

Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption
SIte is stored in a directory called `host` for the URL requested

#### Usage

    websiteScrape siteURL
    

#### Exit codes

- `0` - Always succeeds

<!-- TEMPLATE footer 5 -->
<hr />

[⬅ Top](index.md) [⬅ Parent ](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=Web Functions)
