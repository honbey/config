# Tencent CloudBase

It's not free since 8th August, 2022.

```php
<?php

function main($event, $context) {
    $html=<<<EOF
<!DOCTYPE html>
<html lang="zh-cmn-Hans"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#000000">
    <meta name="description" content="My web development record">
    <link rel="icon" href="//www.freewisdom.cn/static/logo.png">
    <link rel="stylesheet" type="text/css" href="https://cdn.bootcdn.net/ajax/libs/bulma/0.9.2/css/bulma.min.css">
    <title>Honbey 的 Web 开发记录</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"><nav class="navbar"><div class="container"><div class="navbar-brand"><a class="navbar-item" href="/">
      <img alt="logo" src="data:image/png;base64,..." width="28" height="28">
    </a><a class="navbar-burger burger"><span></span><span></span><span></span></a></div><div class="navbar-menu"><div class="navbar-start"><a class="navbar-item" href="https://download.freewisdom.cn/" target="">Download</a></div><div class="navbar-end"><div class="navbar-item"><div class="control has-icons-left"><input class="input" type="text" placeholder="Search"><span class="icon is-left"></span><article class="message is-info is-hidden" style="position: fixed; width: inherit; z-index: 10;"><div class="message-header"><p>Search Result</p><button class="delete"></button></div><div class="message-body">This feature is still in development. Coming soon.</div></article></div></div><div class="navbar-item"><div class="buttons"><a class="button is-primary" href="/#" target=""><strong>Home</strong></a></div></div></div></div></div></nav><section class="hero is-link is-fullheight-with-navbar"><div class="hero-body"><div class="container"><div class="columns is-vcentered"><div class="column"><h1 class="title is-2">HONBEY&apos;S WEB RECORD</h1><h2 class="subtitle is-3">Free Wisdom</h2></div><div class="column">
    <figure class="image is-3by2">
      <img src="//ufile.freewisdom.cn/images/avator-cover.jpg" alt="Cover" style="border-radius: 5px;">
    </figure></div></div></div></div></section>
    <section class="hero">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-3">
            Uptime
          </h1>
          <div class="level is-mobile">
            <div class="level-item has-text-centered">
              <div>
                <p id="days" class="title">703</p>
                <p class="heading">Days</p>
              </div>
            </div>
            <div class="level-item has-text-centered">
              <div>
                <p id="hours" class="title">12</p>
                <p class="heading">Hours</p>
              </div>
            </div>
            <div class="level-item has-text-centered">
              <div>
                <p id="minutes" class="title">8</p>
                <p class="heading">Minutes</p>
              </div>
            </div>
            <div class="level-item has-text-centered">
              <div>
                <p id="seconds" class="title">53</p>
                <p class="heading">Seconds</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  <footer class="footer" style="padding-bottom: 0.5rem;"><div class="container"><div class="columns"><div class="column is-one-third"><div class="content">
    <figure class="image is-128x128">
      <img src="data:image/png;base64,..." alt="logo-192">
    </figure><p>CoryRight © 2019-2021 Honbey</p><p>Power by<strong><a href="https://reactjs.org/"> React </a></strong>&amp;<strong><a href="https://bulma.io/"> Bulma</a></strong>.</p></div></div><div class="column"><div class="columns"><div class="column is-one-fifths"></div><div class="column is-two-fifths"><p>Server</p><p><a href="/#" target="">Agreement</a></p><p><a href="/#" target="">Contact Us</a></p><p><a href="/#About-Me" target="">Developer</a></p><p><a href="/#" target="">FriendLink</a></p><p><a href="/#" target="">Sponsor</a></p><p><a href="/#" target="">This Site</a></p></div><div class="column is-two-fifths"><p>Navigation</p><p><a href="http://download.freewisdom.cn/" target="_blank">Download</a></p></div></div></div></div><div><a href="https://beian.miit.gov.cn/" target="_blank">湘ICP备19014083号</a></div></div></footer></div>
    <script type="text/javascript">
      function calcPassedTime() {
        let passedTime = new Date() - new Date(2019, 6, 16, 9, 0, 22);
        let days = Math.floor(passedTime / 86400000);
        let hours = Math.floor(passedTime / 3600000 % 24);
        let minutes = Math.floor(passedTime / 60000 % 60);
        let seconds = Math.floor(passedTime / 1000 % 60);
        document.getElementById('days').innerText = days;
        document.getElementById('hours').innerText = hours;
        document.getElementById('minutes').innerText = minutes;
        document.getElementById('seconds').innerText = seconds;
        setTimeout("calcPassedTime()", 1000);
      };
      calcPassedTime();
    </script>
  </body>
</html>
EOF;

    error_log( "errors: ..." );
    var_dump($event);
    var_dump($context);

    return [
        'isBase64Encoded' => false,
        'statusCode' => 200,
        'headers' => [ 'Content-Type' => 'text/html' ],
        'body' => $html
    ];
}

?>
```
